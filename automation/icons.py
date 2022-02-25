from operator import le
import time
from selenium import webdriver
import progressbar;

options = webdriver.ChromeOptions()
options.add_argument("user-data-dir=/path/to/your/custom/profile")
options.add_argument("--disable-logging");

driver = webdriver.Chrome("./chromedriver", options=options);

driver.get("https://www.fluttericon.com/");

input("Upload files and press enter...")
start = int(input("Skip icons: "));
length = 2986;
for i in range(start, length):
    progressbar.progress(i, length, f"({i} / {length})");
    driver.find_elements_by_css_selector(f"#custom_icons > div > ul > li:nth-child({i}) > div")[0].click()
    time.sleep(.05)
    
input("Validate results and press enter to continue...")
    