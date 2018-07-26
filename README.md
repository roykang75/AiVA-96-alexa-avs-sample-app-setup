AiVA-96 for AVS SDK on Dragon Board 410c
---
The AiVA-96 for AVS provides far-field voice capture using the XMOS XVF3000 voice processor.

Combined with a Raspberry Pi running the Amazon Alexa Voice Service (AVS) Software Development Kit (SDK), this kit allows you to quickly prototype and evaluate talking with Alexa.

To find out more, visit: https://wiziot home page   
and: https://developer.amazon.com/alexa-voice-service

This respository provides a simple-to-use automated script to install the Amazon AVS SDK on a Dragon Board 410c and configure the Dragon Board 410c to use the AiVA-96 for AVS for audio.

Prerequisites
---

You will need:

- AiVA-96 Board
- Dragon Board 410c
- Dragon Board 410c power supply
- MicroSD card (min. 16GB)
- Monitor with HDMI input
- HDMI cable
- Fast-Ethernet connection with internet connectivity  

You will also need an Amazon Developer account: https://developer.amazon.com


Hardware setup
---
Setup your hardware by following the Hardware Setup at: https://wiziot home page

AVS SDK installation and Dragon Board 410c audio setup
---
Full instructions to install the AVS SDK on to a Dragon Board 410c and configure the audio to use the AiVA-96 are detailed in the Getting Started Guide available from: https://wiziot home page.

Brief instructions and additional notes are below:

1. Install Debian (Stretch) on the Dragon Board 410c.  
   You shoud use [Debian 17.09](http://releases.linaro.org/96boards/dragonboard410c/linaro/debian/17.09/dragonboard410c_sdcard_install_debian-283.zip)

2. Open a terminal on the Dragon Board 410c and clone this repository
    ```
    cd ~; git clone https://github.com/roykang75/AiVA-96-alexa-avs-sample-app-setup.git
    ```   
3. You'll need to register a device and create a security profile at developer.amazon.com. [Click here](https://github.com/alexa/alexa-avs-sample-app/wiki/Create-Security-Profile) for step-by-step instructions.

    IMPORTANT: The allowed origins under web settings should be http://localhost:3000 and https://localhost:3000. The return URLs under web settings should be http://localhost:3000/authresponse and https://localhost:3000/authresponse.

    If you already have a registered product that you can use for testing, feel free to skip ahead.

4. Run the installation script
    ```
    cd AiVA-96-alexa-avs-sample-app-setup/
    bash automated_install.sh
    ```
    If you use wakeWake Word Agent, connect GPIO 36 and GPIO 13 on AiVA-96 board using wire.  
    ![](/assets/wakeword.png)

AVS Run and Authentication
---
to run the Alexa Voice Service, need 4 terminal windows.
windows can be opened manually. See the following for more information.
*These commands should be run in this order.*
```
Terminal Windows 1: to run the web service for authorization
Terminal Windows 2: to run the sample app to communicate with AVS
Terminal Windows 3: to run the wake word engine which allows you to start an interaction using the phrase "Alexa"
Terminal Windows 4: to run the pocketSpinx
```

##### 1. Terminal Window 1 \(Ctrl + Alt + T\)
Open a new terminal window and type the following command to bring up the web service which is used to authorize the sample app with Amazon AVS.
```
cd ~/workspace/alexa-avs-sample-app/samples/companionService && npm start
```
![](/assets/dragonBoard_alexa_step_1.png)

##### 2. Terminal Window 2
Open a new terminal window and type the following commands to run the sample app, which communicates with Amazon AVS.
```
cd ~/workspace/alexa-avs-sample-app/samples/javaclient && mvn exec:exec
```
![](/assets/dragonBoard_alexa_step_2.png)

##### 3. Authentication
- A window should pop up with a message that says -  
    Please register your device by visiting the following URL in a web browser 
    and following the instructions: https://localhost:3000/provision/xxxxxxxxxxx
    Would you like to copied to your clipboard ?
- Click on "Yes".  
    ( IMPORTANT NOTE: Don't respond to the second pop up until after you've logged in to your Amazon account.)
![](/assets/dragonBoard_alexa_step_3.png)

- Run Chromium web browser and then paste URL(Ctrl + V) on clipboard
- Input ENTER key and click on "ADVANCED".
![](/assets/dragonBoard_alexa_step_4.png)

- Click on "Proceed to localhost \(unsafe\)"
![](/assets/dragonBoard_alexa_step_5.png)

- Input Amazon ID and Password and then click on "Sign in"
![](/assets/dragonBoard_alexa_step_6.png)

- You will now be redirected to a URL beginning with https://localhost:3000/authresponse followed by a query string.  
    The body of the web page will say device tokens ready.
![](/assets/dragonBoard_alexa_step_7.png)

- Return to the Java application and click the OK button. The sample app is now ready to accept Alexa requests.
![](/assets/dragonBoard_alexa_step_8.png)

- If the following screen appears, the AVS sample app is executed normally.
![](/assets/dragonBoard_alexa_step_9.png)

##### 4. Terminal Window 3
*Note: Skip this step to run the same app without a wake word engine.*

Open a new terminal window and use the following commands to bring up the wake word engine from pocketSpinx.  
The wake word engine will allow you to initiate interactions using the phrase "Alexa".

```
cd ~/alexa-avs-sample-app/samples/wakeWordAgent/src
sudo ./wakeWordAgent -e gpio
```

##### 5. Terminal Window 4
*Note: Skip this step to run the same app without a wake word engine.*

Open a new terminal window and use the following commands to run pocketSpinx app.
```
cd ~/alexa-avs-sample-app && run_sphinx_no_log.sh
```

Important considerations
---
* Review the AVS [Terms & Agreements](https://developer.amazon.com/public/solutions/alexa/alexa-voice-service/support/terms-and-agreements).  

* The earcons associated with the sample project are for **prototyping purposes only**. For implementation and design guidance for commercial products, please see [Designing for AVS](https://developer.amazon.com/public/solutions/alexa/alexa-voice-service/content/designing-for-the-alexa-voice-service) and [AVS UX Guidelines](https://developer.amazon.com/public/solutions/alexa/alexa-voice-service/content/alexa-voice-service-ux-design-guidelines).
