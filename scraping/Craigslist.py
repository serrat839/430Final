import os
import requests
import time
import math

from bs4 import BeautifulSoup as bs
import pandas as pd
# import pyodbc

urls = []
carMakesUrls = []
csv_filepath = os.path.join(os.path.dirname(__file__), 'craiglistOutputFinal.csv')

def crawl_urls():
    regions = ["bellingham", "kpr", "moseslake", "olympic", "pullman", "seattle", "skagit", "spokane", "wenatchee", "yakima"]
    regionRange = range(0,len(regions))
    
    # Modify url for each region and crawl accordingly
    for regionNum in regionRange:
        homePageFormat = "https://{0}.craigslist.org/d/cars-trucks/search/cta?s=0".format(regions[regionNum])
        homePage = requests.get(homePageFormat)
        soup = bs(homePage.content, 'html.parser')
        totalEntries = int(soup.find("span", attrs={"class": "totalcount"}).text.strip())
        totalPages = math.floor(totalEntries/120)
        pageRange = range(0,totalPages+1)

        # Uncomment this to crawl all pages
        # for pageNum in pageRange:
        for pageNum in range(0,3):
            pageUrl = "https://{0}.craigslist.org/d/cars-trucks/search/cta?s={1}".format(regions[regionNum],pageNum*120)
            page = requests.get(pageUrl)
            soup = bs(page.content, 'html.parser')

            car_links = soup.find_all("a", attrs={"class": "result-title hdrlnk"})
            for link in car_links:
                car_href = link.get('href')
                urls.append(car_href)
                print('Found car href:', car_href)
            
            print('Done crawling page:', pageUrl)

allCarMakes = []

def createCarMakesArray():
    homePage = "https://www.topspeed.com/cars/makes/"
    
    print('Scraping url', homePage)
    urlPage = requests.get(homePage)
    soup = bs(urlPage.content, 'html.parser')
        
    try:
        carMakesList = soup.find_all("div", attrs={"class": "b-category-list-item__title"})
        for carMake in carMakesList:
            carMake1 = str(carMake)
            carMake2 = carMake1[:-6]
            carMakeName = carMake2[41:]
            # If carMakeName contains - (ex: Rolls-Royce), replace it with a space (ex: Rolls Royce)
            if carMakeName.find('-') != -1:
                carMakeName = carMakeName.replace('-', ' ')
            # Website formats GM/General Motors as (ex: GM (General Motors)); fix formatting to GM and General Motors as two separate entries
            if carMakeName.find('GM') != -1 and carMakeName != 'GMC':
                carMakeName = str.split(carMakeName, ' (')[0]
            # Add lowercase version of carMakeName to list
            allCarMakes.append(str.lower(carMakeName))
        # Add Mercedes-Benz manually; website only has "Mercedes", etc.
        allCarMakes.append('mercedes benz')
        allCarMakes.append('chevy')
        allCarMakes.append('studebaker')
        allCarMakes.append('vw')
        allCarMakes.append('triumph')
        allCarMakes.append('mack')
        allCarMakes.append('mack trucks')
    except:
        print('Could not scrape url: ', urlPage)
    
# Sort allCarMakes in alphabetical order, starting with 'a'
allCarMakes = sorted(allCarMakes)

def scrape_urls():
    cars = []
    for url in urls:
        print('Scraping url', url)
        urlPage = requests.get(url)
        soup = bs(urlPage.content, 'html.parser')

        # Find string of carYear, carMake, carModel
        try:
            carInfo = soup.find("p", attrs={"class": "attrgroup"}).span.b.text.strip()
        except:
            print('Could not scrape url: ', url)
            continue

        # Split string into elements of an array, by spaces
        carInfoArr = str.split(carInfo)

        # The first entry should be the year
        carYear = 0
        try:
            carYear = int(carInfoArr[0])
        except:
            carYear = -1

        carMake = ''
        carModel = ''
        try:
            # Some entries on Craigslist list the year twice; account for this
            if carInfoArr[1].isnumeric():
                carInfoArr = carInfoArr[1:]
            carInfo1 = str.lower(carInfoArr[1])
            # If entry after year element has a '-', replace with a ' ' for consistent formatting
            if carInfo1.find('-') != -1:
                    carInfo1 = carInfo1.replace('-', ' ')
            # Check to see if entry after year element is in allCarMakes 
            if carInfo1 in allCarMakes:
                # Check for special cases for consistency in data
                if carInfo1 == 'mercedes benz':
                    carInfo1 = 'mercedes'
                elif carInfo1 == 'gm':
                    carInfo1 = 'general motors'
                elif carInfo1 == 'vw':
                    carInfo1 = 'volkswagen'
                elif carInfo1 == 'chevy':
                    carInfo1 = 'chevrolet'
                elif carInfo1 == 'mack':
                    carInfo1 = 'mack trucks'
                # If this entry is in allCarMakes, carMake is this entry with the first letter of each word capitalized
                carMake = str.title(carInfo1)
                # carModel is the rest of the string
                carModel1 = " ".join(carInfoArr[2:])
                carModel = str.title(carModel1)
            else:
                # If entry after year wasn't in allCarMakes, see if first two entries, combined with a space, after year is
                carInfo2 = str.lower(carInfoArr[1] + ' ' + carInfoArr[2])
                if carInfo2 in allCarMakes:
                    carMake = str.title(carInfo2)
                    carModel1 = " ".join(carInfoArr[3:])
                    carModel = str.title(carModel1)
                else:
                    carInfo3 = str.lower(carInfo2 + ' ' + carInfoArr[3])
                    if carInfo3 in allCarMakes:
                        carMake = str.title(carInfo3)
                        carModel1 = " ".join(carInfoArr[4:])
                        carModel = str.title(carModel1)
        except:
            carMake = 'N/A'
            carModel = 'N/A'
        
        carPrice = 0
        try:
            carPrice1 = soup.find("span", attrs={"class": "price"}).text.strip()[1:]
            carPrice2 = carPrice1.replace(',', '')
            carPrice = float(carPrice2)
        except:
            carPrice = -1

        # Find string of attributes, including condition and miles on car (odometer)
        attributeList = []
        try:
            attributes = soup.find("p", attrs={"class": "attrgroup"}).next_sibling.next_sibling.find_all('span')
            attributeList = []
            for attribute in attributes:
                attributeList.append(attribute.text.strip())
        except:
            attributeList = ['N/A']

        carCondition = ''
        try:
            sub = 'condition: '
            carConditionStr = next((s for s in attributeList if sub in s), None)
            carCondition = carConditionStr[len(sub):]
        except:
            carCondition = 'N/A'

        milesOnCar = 0
        try:
            sub = 'odometer: '
            milesOnCarStr = next((s for s in attributeList if sub in s), None)
            milesOnCar = int(milesOnCarStr[len(sub):])
        except:
            milesOnCar = -1

        postingDate = ''
        try:
            postingDate = soup.find("time", {"class": "date timeago", "datetime": True})['datetime'][:10]
        except:
            postingDate = 'N/A'

        postingUrl = url

        carImageLinks = []
        try:
            links = soup.find("div", attrs={"id": "thumbs"}).find_all('a')
            for element in links:
                link = element['href']
                carImageLinks.append(link)
        except:
            carImageLinks = ['N/A']

        regionsDict = {"bellingham": "Bellingham", "kpr": "Kennewick-Pasco-Richland", "moseslake": "Moses Lake", 
                       "olympic": "Olympic Peninsula", "pullman": "Pullman / Moscow", "seattle": "Seattle-Tacoma", 
                       "skagit": "Skagit Island / San Juan Islands", "spokane": "Spokane / Coeur d'Alene", 
                       "wenatchee": "Wenatchee", "yakima": "Yakima"}

        postingRegion1 = url[8:]
        postingRegion2 = str.split(postingRegion1, '.')
        postingRegion3 = str.lower(postingRegion2[0])
        postingRegion = regionsDict[postingRegion3]

        print(carMake, carModel, carYear, carPrice, carCondition, milesOnCar, postingDate, postingUrl, carImageLinks, postingRegion)
        cars.append([carMake, carModel, carYear, carPrice, carCondition, milesOnCar, postingDate, postingUrl, carImageLinks, postingRegion])
        # Sleeping for 1 second to be nice to Craigslist
        time.sleep(1)

    columns = ['CarMake', 'CarModel', 'CarYear', 'CarPrice', 'CarCondition', 'MilesOnCar', 'PostingDate', 'PostingUrl', 'CarImageLinks', 'PostingRegion']
    df = pd.DataFrame(cars, columns=columns)
    
    df.to_csv(csv_filepath, index = False)

def insert_to_db():
    # Read our csv we created earlier but tell Pandas to not mess with 'N/A' values
    df = pd.read_csv(csv_filepath, keep_default_na=False)

    server = 'is-info430.ischool.uw.edu'
    database = 'HW4'
    username = 'INFO430'
    password = 'SuperSafePassword1234'
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
    cursor = conn.cursor()
    for index, row in df.iterrows():
        cursor.execute("INSERT INTO dbo.hriggs_recipes (CarMake, CarModel, CarYear, CarPrice, CarCondition, MilesOnCar, PostingDate, PostingUrl, CarImageLinks, PostingRegion) values(?,?,?,?,?,?,?,?,?)", row.CarMake, row.CarModel, row.CarYear, row.CarPrice, row.CarCondition, row.MilesOnCar, row.PostingDate, row.PostingUrl, row.CarImageLinks, row.PostingRegion)
    conn.commit()
    cursor.close()

if __name__ == '__main__':
    crawl_urls()
    createCarMakesArray()
    scrape_urls()
    # insert_to_db()