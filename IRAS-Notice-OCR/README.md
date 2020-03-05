## IRAS.gov.sg - extract details from document using OCR ([download template](https://github.com/aimakerspace/TagUI-Bricks/releases/download/v1.0.0/IRAS-Notice-OCR.zip))

This automation flow downloads a document from IRAS and uses OCR to extract information from the document. Accounting firms can do this at scale to download and automate part of their business processes for clients.

![iras_ocr.gif](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/IRAS-Notice-OCR/iras_ocr.gif)

#### TagUI Workflow

```
// visit IRAS website (for managing taxes in Singapore) 
https://www.iras.gov.sg/irashome/default.aspx

// bring Chrome web browser to foreground to be in focus,
// for subsequent steps to click visually on UI elements
click chrome_icon.png

// increase timeout from default 10 seconds to 300 seconds
// to let user sign in, including using 2FA authentication
timeout 300

// log in to personal income tax using visual automation,
// instead of specifying XPath or other web identifiers
// that natively interact with web browser's backend
click login_menu.png
click mytax_option.png
click personal_button.png

// click property tax option under notices menu
click notices_menu.png
click property_option.png

// click link using smart web identifier, in this case text() -
// TagUI auto-selects provided web identifier in following order
// XPath, CSS, id, name, class, title, aria-label, text(), href
click View Notices

// explicitly wait for some time (default is 5 seconds)
wait

// before sending keystrokes to scroll down the page
keyboard [down][down][down][down][down][down][down][down]
keyboard [down][down][down][down][down][down][down][down]

// click to download IRAS notice document in PDF format 
click claim_notification.png

// wait for some time before using keystrokes to open PDF,
wait

// using Spotlight Search on macOS to search for filename
// (there are other ways of opening the PDF on other OSes)
keyboard [cmd][space]
keyboard not-oo[enter]

// wait to make sure PDF is opened in PDF viewer window
// (this is a lazy way, a better way is to use hover step
// on the UI element to look out for until timeout happens)
wait

// move mouse cursor to show the rectangle boundary for OCR
hover (160,200)
hover (380,300)

// use OCR to read text from a pre-defined rectangle region
read (160,200)-(380,300) to property_address

// scroll down to the second page of PDF using the keyboard
keyboard [shift][down][down][down][down][down][down][down]

// use OCR to read text, by using an anchor image and offset
hover lines_anchor.png
x = mouse_x()
y = mouse_y()
top_left_x = x
top_left_y = y - 20
bottom_right_x = x + 160
bottom_right_y = y + 20

// backticks pair `` is used to denote variables instead of text
read (`top_left_x`,`top_left_y`)-(`bottom_right_x`,`bottom_right_y`) to tax_amount

// show popup in browser with property address and tax amount before exiting
// use dom_json variable and dom step to run JavaScript code in browser
dom_json = {property_address: property_address, tax_amount: tax_amount}
dom alert('Tax amount is ' + dom_json.tax_amount + ' for the property ' + dom_json.property_address)
```

>In this automation workflow, the PDF document is a text document, which has better ways to extract text content instead of using OCR. OCR is used for demo purpose to show how an image PDF may be handled.

#### Image Assets

![iras_ocr.gif](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/IRAS-Notice-OCR/iras_ocr.png)
