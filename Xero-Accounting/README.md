## Xero Accounting - download report from Xero accounting ([download template](https://github.com/aimakerspace/TagUI-Bricks/releases/download/v1.0.0/Xero-Accounting.zip))

This automation flow downloads a specific recurring report from Xero cloud accounting software. It is created at [CA Trust PAC](https://casingapore.org), an accounting firm in Singapore, with the help of intern students from [Temasek Polytechnic](https://www.tp.edu.sg).

![xero_cover.png](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/Xero-Accounting/xero_cover.png)

#### TagUI Workflow
```
// start by opening existing browser session
// and create a new tab to visit Xero homepage
click chromelogo.png
click newtab.png
keyboard https://go.xero.com[enter]

// enter credentials and login by using [ctrl]a
// to select any pre-filled text and type over
click email.png
keyboard [ctrl]a
keyboard your_email
click password.png
keyboard [ctrl]a
keyboard your_password
click loginbutton.png
wait 2 seconds 

// navigate to the aged receivables report
click accountingmenu.png
click reportoption.png
click agedreceivablebutton.png
wait 10 seconds

// enter filter criteria for the report
click reportsettingsbutton.png
click todaydropdown.png
click endoflastmonth.png
click standarddropdown.png
click groupbyoption.png
click contactgroupdropdown.png
click partneroption.png
click updatebutton.png
wait 2 seconds

// download the report to Excel spreadsheet
click exportbutton.png
click excelbutton.png
wait 5 seconds

// log out so that users can sign in again
click profilebutton.png
click logoutbutton.png
wait 3 seconds

// close the new tab opened at the start
keyboard [ctrl]w
```

>In this workflow, visual automation is used to interact with UI elements on Xero website using image snapshots. Using web element identiers work as well, if not better. In that mode, user will not see the mouse cursor moving.

#### Image Assets

![xero_accounting.png](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/Xero-Accounting/xero_accounting.png)
