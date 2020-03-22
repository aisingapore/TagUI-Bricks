// This automation workflow grabs WHO daily situation report (PDF file),
// extracts a summary of the latest statistics, and emails the summary.
// The automation can be run using - tagui who_report.tag -nobrowser
// or scheduled using crontab scheduler to repeat daily automatically.

// This workflow is designed for macOS as keyboard shortcuts are
// specific to macOS. Also, for WHO daily report landing page,
// Chrome browser is set to 200% zoom to ensure correct matching
// using OCR and computer vision to interact with the website.

// For the Gmail portion, the browser zoom is set to 125% for better
// visibility during recording of the video. Computer vision and OCR
// is used in this workflow as Gmail recently blocks browser automation,
// thus Gmail interactions cannot be done using web element identifiers.

js begin
// define list of countries for accurate extraction from PDF table
// primary list from countries in the report
country_list = [
    'Singapore',
    'Japan',
    'Republic of Korea',
    'Malaysia',
    'Australia',
    'Viet Nam',
    'Philippines',
    'Cambodia',
    'Thailand',
    'India',
    'Nepal',
    'Sri Lanka',
    'United States of America',
    'Canada',
    'Germany',
    'France',
    'The United Kingdom',
    'Italy',
    'Russian Federation',
    'Spain',
    'Belgium',
    'Finland',
    'Sweden',
    'United Arab Emirates',
    'Iran (Islamic Republic of)',
    'Egypt',
    'International conveyance'
]

country_list_backup = ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua And Barbuda", "Argentina", "Armenia", "Aruba", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia (Plurinational State of)", "Bonaire, Sint Eustatius And Saba", "Bosnia And Herzegovina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cameroon", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "Christmas Island", "Cocos Islands", "Colombia", "Comoros", "Democratic Republic of the Congo", "Congo", "Cook Islands", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czechia", "Czech Republic", "Denmark", "Djibouti", "Dominican Republic", "Dominica", "Ecuador", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands", "Faroe Islands", "Fiji", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guernsey", "Guinea", "Guinea-bissau", "Guyana", "Haiti", "Heard Island And Mcdonald Islands", "Holy See", "Honduras", "Hong Kong", "Hungary", "Iceland", "Indonesia", "Iraq", "Ireland", "Isle Of Man", "Israel", "Jamaica", "Jersey", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "North Korea", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macao", "Macedonia", "Madagascar", "Malawi", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States Of", "Republic of Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Netherlands", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Palestine, State Of", "occupied Palestinian territory", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Rwanda", "Saint Barthelemy", "Saint Helena, Ascension And Tristan Da Cunha", "Saint Kitts And Nevis", "Saint Lucia", "Saint Martin", "Saint Pierre And Miquelon", "Saint Vincent And The Grenadines", "Samoa", "San Marino", "Sao Tome And Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Sint Maarten", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia And The South Sandwich Islands", "South Sudan", "Sudan", "Suriname", "Svalbard And Jan Mayen", "Swaziland", "Switzerland", "Syrian Arab Republic", "Taiwan", "Tajikistan", "Tanzania", "Timor-leste", "Togo", "Tokelau", "Tonga", "Trinidad And Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks And Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela, Bolivarian Republic Of", "Virgin Islands, British", "Virgin Islands", "Wallis And Futuna", "Western Sahara", "Yemen", "Zambia", "Zimbabwe"];

// append secondary list from ISO definitions as a backup
country_list = country_list.concat(country_list_backup)
js finish

// launch user normal Chrome browser (to allow Gmail login)
// to capture statistics from the latest situation report
js clipboard('https://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports/')
keyboard [cmd][space]
keyboard chrome[enter]

// wait for a few seconds to ensure Chrome is ready to launch new tab
// user might have an open session, can't wait for Google image snapshot
wait

// click on Google taskbar icon to ensure browser is in focus
click google.png

// before pasting report URL from clipboard to URL textbox
keyboard [cmd]t
keyboard [cmd]l
keyboard [cmd]v
keyboard [enter]

// click on situation report link with running report number
// for first run, set report_count.txt to latest count minus 1
// clicking of the link is done using OCR and computer vision
load report_count.txt to report_count
report_count = (parseInt(report_count.trim(), 10) + 1).toString()
dump `report_count` to report_count.txt

// give some time for OCR to detect text to click
timeout 30 seconds
click Situation report - `report_count` using ocr
timeout 10 seconds

// click to ensure report PDF has been loaded
// before carrying out the next steps below
click who_logo.png

// copy report URL to clipboard for later use
keyboard [cmd]l
keyboard [cmd]c
report_url = clipboard()

// click to set PDF web control to be in focus
click who_logo.png

// use shortcut keys to copy and store PDF text
keyboard [cmd]a
keyboard [cmd]c
pdf_result = clipboard()

// define header text to be send in the email distribution
statistics_summary = 'Below are the latest statistics from WHO daily report -' + '\n' + report_url + '\n'
statistics_details = ''

// special handling for China as it is no longer in the table
country_result = get_china_stats()
echo `country_result.name` - `country_result.stats`
statistics_details += country_result.name + ' - ' + country_result.stats + '\n'

// segment the section containing country statistics
country_start_marker = 'Western Pacific Region'
country_finish_marker = '*Numbers include both domestic and repatriated cases'
pdf_result = pdf_result.substring(pdf_result.indexOf(country_start_marker), pdf_result.indexOf(country_finish_marker))

// remove region description for cleaner processing later
pdf_result = pdf_result.replace('Western Pacific Region', '')
pdf_result = pdf_result.replace('South-East Asia Region', '')
pdf_result = pdf_result.replace('Region of the Americas', '')
pdf_result = pdf_result.replace('European Region', '')
pdf_result = pdf_result.replace('Eastern Mediterranean Region', '')
pdf_result = pdf_result.replace('African Region', '')
pdf_result = pdf_result.replace('Territories**', '')

// clean up countries with names displayed on multiple lines
pdf_result = pdf_result.replace('United States of\nAmerica', 'United States of America')
pdf_result = pdf_result.replace('International\nconveyance', 'International conveyance')
pdf_result = pdf_result.replace('Bosnia and\nHerzegovina', 'Bosnia and Herzegovina')
pdf_result = pdf_result.replace('Iran (Islamic Republic\nof)', 'Iran (Islamic Republic of)')
pdf_result = pdf_result.replace('occupied Palestinian\nterritory', 'occupied Palestinian territory')
pdf_result = pdf_result.replace('Bolivia (Plurinational\nState of)', 'Bolivia (Plurinational State of)')
pdf_result = pdf_result.replace('Democratic Republic\nof the Congo', 'Democratic Republic of the Congo')

// clean up cruise ship Diamond Princess exception for stats
pdf_result = pdf_result.replace('(Diamond Princess)', '').replace('(Diamond\nPrincess)', '')

// replace line breaks to remove inconsistencies in the table
pdf_result = pdf_result.replace(/\n/g, ' ')

// scans through PDF text to extract country and statistics
for country_count from 1 to 999
{
    country_result = next_country_stats()
    echo `country_result.name` - `country_result.stats`
    statistics_details += country_result.name + ' - ' + country_result.stats + '\n'
    if country_result.name equals to 'International conveyance'
        break
}

// sort list of countries by alphabetical order
statistics_details = statistics_details.split('\n')
statistics_details = statistics_details.sort().join('\n')
statistics_summary += statistics_details

// save a copy of the email content for reference
dump `statistics_summary` to statistics.txt

// close Chrome tab for report pdf
keyboard [cmd]w

// close Chrome tab for main report page if still there
// some days report pdf launches in new tab, some don't
if present('report_tab.png')
keyboard [cmd]w

// open Gmail to send statistics summary to mailing list
js clipboard('https://mail.google.com/mail/u/1/#inbox')
keyboard [cmd]t
keyboard [cmd]l
keyboard [cmd]v
keyboard [enter]

// click new email icon and wait for a few seconds,
// before using keyboard combinations to paste text.
// text can also be typed character by character,
// which is much slower as there's a lot of text.
click new_email.png
wait 2.5 seconds

// paste email distribution list to To: field
js clipboard('distribution_list@aisingapore.org')
keyboard [cmd]v
keyboard [tab]

// paste email subject to Subject: field
js clipboard('WHO COVID-19 Daily Report')
keyboard [cmd]v
keyboard [tab]

// paste email content to email body
js clipboard(statistics_summary)
keyboard [cmd]v

// click on send button to send email
click send_email.png
wait 15 seconds

// close Gmail browser tab
keyboard [cmd]w
