// This automation flow gets forex rates from DBS.com
// and sends a csv file of the forex rates using Gmail. 
// The flow was done on macOS Google Chrome at 125% zoom,
// images may have to be replaced with your browser's to work.

// visit DBS website with a table of foreign currency exchange rates
https://www.dbs.com.sg/personal/rates-online/foreign-currency-foreign-exchange.page

// create a blank csv file with the header row containing 2 columns
dump Currency,Rate to numbers.csv

// extract only the main forex rates table with 19 rows of data
for row from 1 to 19
{
    // XPath is a powerful way to identify webpage UI elements
    // intro to XPath - https://builtvisible.com/seo-guide-to-xpath

    // form XPath element identifiers for cells in table
    read ((//*[contains(@class,"tbl-primary")]/tbody/tr)[`row`]//td)[1] to currency
    read ((//*[contains(@class,"tbl-primary")]/tbody/tr)[`row`]//td)[3] to rate

    // show the forex rate as it is being extracted
    echo 1 `currency` to S$`rate`

    // save current row of forex rate to the csv file
    // by using csv_row() function on an array of fields
    forex_rate = [currency, 'S$' + rate]
    write `csv_row(forex_rate)` to numbers.csv
}

// increase timeout from default 10 seconds to 60 seconds,
// to let user sign in to Gmail if it is not yet signed in
timeout 60 seconds

// Gmail is used here to send email, but desktop apps such as Outlook
// can also be used by providing image snapshots of their UI elements.
// To use image snapshots in this workflow, set the browser to 125% zoom.
// (Chrome was set at 125% zoom for this workflow to show actions clearly)
https://mail.google.com/mail/u/0/

// set focus to Chrome browser and compose a new message
click chrome_icon.png
click gmail_compose.png

// fill up different fields in the new message window
// change to your email address to test this workflow
type gmail_to.png as email@your_domain.com
enter gmail_body.png as Hi Boss,[enter][enter]Attached are the forex rates for today.[enter][enter]Regards,[enter]Ken
type gmail_subject.png as Daily Forex Rates

// attach csv file of forex rates and send the email
// (assume current folder is at the workflow location)
click gmail_attach.png
click numbers_icon.png
click gmail_open.png

// wait a while to make sure csv file has been uploaded
wait 5 seconds
click gmail_send.png

// wait for some time to see the email in your inbox
wait 15 seconds

// In normal situations, Chrome must be set at 100% zoom for TagUI to work.
// Because TagUI replicates mouse clicks at the x,y coordinates of elements.
// Here, visual automation method is used, thus 125% zoom works for Gmail.

// Workflows can be scheduled to run periodically as required.
// Eg using task scheduler on Windows or crontab on macOS & Linux
// to schedule outside of office hours or on a dedicated computer.
