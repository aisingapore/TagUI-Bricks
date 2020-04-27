// This automation workflow grabs MOH daily situation report (PDF file),
// creates a snapshot of the latest statistics, and emails the summary.
// The automation can be run using tagui moh_report.tag or scheduled
// using crontab scheduler to repeat the report daily automatically.

// This workflow is designed for macOS as keyboard shortcuts
// are specific to macOS (can be changed to work on Windows).
// For the Gmail portion, the browser zoom is set to 125%
// for better visibility during recording of the video.

// go to MOH website and load the latest report
https://www.moh.gov.sg/covid-19/situation-report
click Situation Report -

// wait 5 seconds to ensure that PDF report is loaded
wait

// click on Google taskbar icon to ensure browser is in focus
click chrome_icon.png

// move mouse cursor away to prevent blocking of PDF report,
// else there is a popup tooltip on macOS blocking browser
hover (0,0)

// zoom in PDF report for better readability of table
keyboard [cmd]+

// capture screenshot of outbreak statistics table,
// subjected to change if report format changes,
// and depends on the window position on the PC.
snap (163,340)-(1307,815) to moh_stats.png

// open Gmail to send statistics table to mailing list
js clipboard('https://mail.google.com/mail/u/0/#inbox')
keyboard [cmd]l
keyboard [cmd]v
keyboard [enter]

// click new email icon and wait for a few seconds,
// before using keyboard combinations to paste text.
// text can also be typed out character by character
// using type step, but that is slower than pasting.
click new_email.png
wait 2.5 seconds

// paste email distribution list to To: field
js clipboard('ksoh@aisingapore.org')
keyboard [cmd]v
keyboard [tab]

// paste email subject to Subject: field
js clipboard('MOH COVID-19 Daily Report')
keyboard [cmd]v
keyboard [tab]

// paste email content to message body
js clipboard('Here is a detailed breakdown of the COVID-19 cases in Singapore -')
keyboard [cmd]v
keyboard [enter][enter]

// attach statistics snapshot as inline attachment
click insert_button.png
click upload_tab.png
click choose_button.png
click stats_image.png
click open_button.png
wait 5 seconds

// click on send button to send email
click send_email.png
wait 15 seconds

// close Gmail browser tab
keyboard [cmd]w
