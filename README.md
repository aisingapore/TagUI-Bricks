# TagUI Bricks

[TagUI is an open-source RPA tool](https://github.com/kelaberetiv/TagUI) that runs workflows written in over 20 human languages, to automate digital processes involving computer applications. Below are automation workflows which you can use as sample templates to accelerate your RPA development. Click on the workflow description for more details of each template.

For questions on these workflows, [raise a GitHub issue here](https://github.com/aimakerspace/TagUI-Bricks/issues). Community contributions are welcome. If you are using TagUI for an existing workflow and found it to be useful, raise an issue so that we can guide you through a PR (pull request) to commit to this repository of sample templates.

# Sample Templates ([download these templates](https://github.com/aimakerspace/TagUI-Bricks/releases/download/v1.0.0/TagUI-Bricks.zip))

## [DBS.com & Gmail - download forex rates and email](https://github.com/aimakerspace/TagUI-Bricks/tree/master/DBS-Forex-Gmail) ([download template](https://github.com/aimakerspace/TagUI-Bricks/releases/download/v1.0.0/DBS-Forex-Gmail.zip))

This automation flow gets forex rates from DBS.com and sends a csv file of the forex rates using Gmail. The Gmail portion was done on macOS Chrome at 125% zoom, images may have to be replaced with your browser's to work.

![forex_gmail.gif](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/DBS-Forex-Gmail/forex_gmail.gif)

## [IRAS.gov.sg - extract details from document using OCR](https://github.com/aimakerspace/TagUI-Bricks/tree/master/IRAS-Notice-OCR) ([download template](https://github.com/aimakerspace/TagUI-Bricks/releases/download/v1.0.0/IRAS-Notice-OCR.zip))

This automation flow downloads a document from IRAS and uses OCR to extract information from the document. Accounting firms can do this at scale to download and automate part of their business processes for clients.

![iras_ocr.gif](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/IRAS-Notice-OCR/iras_ocr.gif)

## [Microsoft Word - automate printing of thank you letters](https://github.com/aimakerspace/TagUI-Bricks/tree/master/MS-Word-Letter) ([download template](https://github.com/aimakerspace/TagUI-Bricks/releases/download/v1.0.0/MS-Word-Letter.zip))

This automation flow opens a Microsoft Word document, fills up required information and prints the document. The flow was done for macOS Microsoft Word at 200% zoom, images must be replaced with your environment's to work.

![letter_flow.gif](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/MS-Word-Letter/letter_flow.gif)

## [RedMart.com - repeat or reschedule groceries order](https://github.com/aimakerspace/TagUI-Bricks/tree/master/RedMart-Order) ([download template](https://github.com/aimakerspace/TagUI-Bricks/releases/download/v1.0.0/RedMart-Order.zip))

This automation flow can be used to repeat or reschedule a groceries order on RedMart base on a previous order. RedMart has no way to repeat or reschedule an order besides manually clicking to add item by item from an old order.

![redmart_order.gif](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/RedMart-Order/redmart_order.gif)

## [WHO Report - extract and email statistic](https://github.com/aimakerspace/TagUI-Bricks/tree/master/WHO-Report) ([download template](https://github.com/aimakerspace/TagUI-Bricks/releases/download/v1.0.0/WHO-Report.zip))

This automation workflow grabs WHO daily situation report (PDF file), extracts a summary of the latest statistics, and emails the summary. The automation can be run using `tagui who_report.tag -nobrowser` or scheduled using crontab scheduler to repeat daily automatically. See workflow link above with comments on how it is done.

![who_report.gif](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/WHO-Report/who_report.gif)

## [MOH Report - extract and email statistic](https://github.com/aimakerspace/TagUI-Bricks/tree/master/MOH-Report) ([download template](https://github.com/aimakerspace/TagUI-Bricks/releases/download/v1.0.0/MOH-Report.zip))

This automation workflow grabs MOH daily situation report (PDF file), creates a snapshot of the latest statistics, and emails the summary. The automation can be run using `tagui moh_report.tag` or scheduled using crontab scheduler to repeat the report daily automatically.

![moh_report.gif](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/MOH-Report/moh_report.gif)

# Community Templates

## [IMDA ICMS - upload trainees details for CITREP](https://github.com/aimakerspace/TagUI-Bricks/tree/master/IMDA-ICMS-CITREP) ([download template](https://github.com/aimakerspace/TagUI-Bricks/releases/download/v1.0.0/IMDA-ICMS-CITREP.zip))

This automation flow performs bulk registration for trainees through IMDA ICMS website (CITREP) used by course providers. You can use this template to modify parameters accordingly, and use the sample csv datatable template.

![citrep_upload.gif](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/IMDA-ICMS-CITREP/citrep_upload.gif)

## [Xero Accounting - download report from Xero accounting](https://github.com/aimakerspace/TagUI-Bricks/tree/master/Xero-Accounting) ([download template](https://github.com/aimakerspace/TagUI-Bricks/releases/download/v1.0.0/Xero-Accounting.zip))

This automation flow downloads a specific recurring report from Xero cloud accounting software. It is created at [CA Trust PAC](https://casingapore.org), an accounting firm in Singapore, with the help of intern students from [Temasek Polytechnic](https://www.tp.edu.sg).

![xero_cover.png](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/Xero-Accounting/xero_cover.png)

# Sponsor
This project  is supported by the National Research Foundation, Singapore under its AI Singapore Programme (AISG-RP-2019-050). Any opinions, findings and conclusions or recommendations expressed in this material are those of the author(s) and do not reflect the views of National Research Foundation, Singapore.
