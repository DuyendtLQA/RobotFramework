# lqa
<!-- Test -->
* robot -d results/ --variable environment_file:stage_environment.robot  test_suites/test_login.robot

**1. Install Robot Framework in Windows**
**1.1. Install python**
* Download lastest version python
* Run .exe file to install python
 - python: download python (add environment)
 - selenium: pip install selenium
 - robotframework: pip install robotframework
 - robotframework-selenium:  pip install robotframework-seleniumlibrary
 - vscode
 - chromedriver: download , add environment

**1.2. Install chromedriver**
* Download chromedriver version according to current version of chrome: https://chromedriver.chromium.org/downloads
* Create "bin" folder in your computer and contain extracted chromedriver file
* Add "bin" folder to PATH (at Advanced System Setting -> Environment Variables -> Add "bin" folder to Path of System Variables)


**2. INSTALL ENVIRONMENT ROBOT FRAMEWORK (Linux)**

**2.1. Install python**
* sudo add-apt-repository ppa:deadsnakes/ppa
* sudo apt install python3.8

**2.2. Install pip**
* sudo apt-get install -y python3-pip
* sudo apt-get install -y unzip xvfb libxi6 libgconf-2-4
* sudo apt-get install default-jdk

**2.3. Install chrome driver**
* wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip

* unzip chromedriver_linux64.zip
* sudo mv chromedriver /usr/bin/chromedriver
* sudo chown root:root /usr/bin/chromedriver

**2.4. Set permission chrome**
* sudo chmod +x /usr/bin/chromedriver

**2.5. Install library**
* pip3 install robotframework
* pip3 install robotframework-seleniumlibrary
* pip3 install robotframework-selenium2library

**2.6. Install jdk**
* sudo apt-get install default-jdk


