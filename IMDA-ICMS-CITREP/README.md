## IMDA ICMS - upload trainees details for CITREP ([download template](https://github.com/aimakerspace/TagUI-Bricks/releases/download/v1.0.0/IMDA-ICMS-CITREP.zip))

This automation flow performs bulk registration for trainees through IMDA ICMS website (CITREP) used by course providers. You can use this template to modify parameters accordingly, and use the sample csv datatable template.

![citrep_upload.gif](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/IMDA-ICMS-CITREP/citrep_upload.gif)

#### TagUI Workflow

```
// perform login steps only for the first iteration in datatable.
// when run with speed option, no login needed for subsequent records
// (line indentation within brackets are optional, either way works)

if iteration equals to 1
{
    // visit IMDA ICMS website for managing CITREP
    https://eservice.imda.gov.sg/icms/initializeHomePage.action

    // login using CorpPass and let user read the ICMS intro
    click Login with CorpPass

    // increase timeout from default 10 seconds to 600 seconds
    // to let user sign in, including using 2FA authentication
    // (and reading the ICMS intro, before user clicks Proceed)
    timeout 600

    // automated bulk registration starts from here
    // choose CITREP option and the CP AO role
    click progType
    click Course Provider Administrative Officer
}

// change timeout to 1 minute, the maximum time to wait
// for web elements on webpage to appear before quitting
timeout 60

// specify main page to go for subsequent iterations
https://eservice.imda.gov.sg/icms/inbox.action

// for some accounts which do not have menu expanded
hover MENU
if present('//*[@class=" hidden"]')
    click MENU
 
// choose Trainee Enrolment and New Enrolment
click Trainee Enrolment
click New Enrolment

// Programme Name: CITREP+ : SF (1 April 2019 - 31 March 2011)
// 38 is the value of above dropdown option
select programmeName as 38

// Total No. of Trainees to be enrolled: 1
type traineeNum as 1

// Course/Certification Title: Practical Foundations in AI with Python
// 11414 is the value of above dropdown option
select courseTitleMain as 11414

// Funding Support Type: Course Fees
// CF is the value of above dropdown option
select fundingTypeMain as CF

// Start Date: 15/11/2019 and End Date: 30/11/2019
type courseStartDateMain as 15/11/2019
type courseEndDateMain as 30/11/2019

// click Go button to proceed
click Go

// Application Category: Self-Sponsored
click SS

// enter trainee details using datatable fields
type traineeName as `Full Name`
type emailAdd as `Email Address`

// click the radio button for Profession:
// (line indentation within conditions are optional)
if '`Profession`' equals to 'Professional'
    click professionCodeIT

else if '`Profession`' equals to 'Student'
    click professionCodeSTD

else if '`Profession`' equals to 'Full-Time National Service (NSF)'
    click professionCodeNSM

// select dropdown option for Trainee Type:
// by using option value of the dropdown option
if '`Trainee Type`' equals to 'NSF/Professional/Student'
    select algolOfClaimType0 as PRO

else if '`Trainee Type`' equals to 'Professional aged 40 years old and above'
    select algolOfClaimType0 as FYO

// Funding Support Type: Course Fees
// CF is the value of above dropdown option
select fundingSurpportType0 as CF

// Fees: 600
type courseFee0 as 600

// Mode of Delivery: Blended
// HYB is the value of above dropdown option
select deliveryMode0 as HYB

// element identifiers for checkboxes at bottom of the page
// CheckList_10536 - a. Proof of Matriculation - for student
// CheckList_10537 - b. Recommendation by the PSEI (refer to Form 1) - for student
// CheckList_10533 - c. Documentation Proof of Enlistment and Operationally Ready Date (ORD) - for NSF
// CheckList_10532 - d. Copy of trainee's SAF 11B card - for NSF
// CheckList_10535 - e. Applicants below eighteen (18) years old as of 1 Jan of the current year need to seek parent/guardian's consent to attend the course/certification. Refer to Form 1A
// CheckList_10534 - f. Company Declaration of SME Status for Funding Support (refer to (Form 2) - for SMEs 

// define a more human-readable identifier variable
// using similar identifier format used by this website
chooseFile = '[name="detailInfoList[0].file"]'

if '`Profession`' equals to 'Student'
{
    click CheckList_10537
    upload `chooseFile` as `Form 1` 
    hover `Form 1`

    click CheckList_10536
    upload `chooseFile` as `Proof of Matriculation`
    hover `Proof of Matriculation`

    if '`Form 1A`' not equals to '-'
    {
        click CheckList_10535
        upload `chooseFile` as `Form 1A`
        hover `Form 1A`
    }
}

else if '`Profession`' equals to 'Full-Time National Service (NSF)'
{
    click CheckList_10533
    upload `chooseFile` as `Proof of Enlistment and ORD`
    hover `Proof of Enlistment and ORD`

    click CheckList_10532
    upload `chooseFile` as `Copy of SAF 11B Card`
    hover `Copy of SAF 11B Card`
}

// for the first record, let user manually check through
// and click submit, declaration and confirmation manually.
// for rest of records, automate submission and confirmation

if `iteration` equals to 1
{
    // use dom step to run JavaScript code on web browser to show message
    dom alert('For this first record, please check through and submit manually')
}

else
{
    // click Submit button to continue
    click submit-btn

    // tick checkboxes for declaration
    click declare0
    click declare1

    // click Proceed to Submit button
    click approve
}

// store Enrolment ID for record purposes
trainee_count = '`[iteration]`'
read //*[@id="TeSuccessForm"]/table/tbody/tr[2]/td/table/tbody/tr[2]/td/table/tbody/tr[2]/td[2]/table/tbody/tr/td[1]/span to trainee_name
read //*[@id="TeSuccessForm"]/table/tbody/tr[2]/td/table/tbody/tr[2]/td/table/tbody/tr[2]/td[2]/table/tbody/tr/td[3]/span to enrolment_id
trainee_info = [trainee_count, trainee_name, enrolment_id]
write `csv_row(trainee_info)` to upload_results.csv

// click OK button to continue
click //*[@id="TeSuccessForm"]/table/tbody/tr[2]/td/table/tbody/tr[3]/th/input

// wait for some time before continuing (default is 5 seconds)
wait
```

>To run this workflow, use `tagui citrep_upload.txt trainee_data.csv speed chrome`, to specify that you want to automate the batch of records in trainee_data.csv and without restarting Chrome for each iteration (login once).

#### Sample Datatable

Full Name|Email Address|Profession|Trainee Type|Form 1|Proof of Matriculation|Form 1A|Proof of Enlistment and ORD|Copy of SAF 11B Card
:--------|:------------|:---------|:-----------|:-----|:---------------------|:------|:--------------------------|:---------------------
Johnny Depp|johnny.depp@gmail.com|Professional|Professional aged 40 years old and above|-|-|-|-|-
Katy Perry|katy.perry@gmail.com|Professional|NSF/Professional/Student|Form_1.pdf|Matriculation.pdf|-|-|-
