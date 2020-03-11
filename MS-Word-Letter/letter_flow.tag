// This automation flow opens a Microsoft Word document,
// fills up required information and prints the document.
// The flow was done for macOS Microsoft Word at 200% zoom,
// images must be replaced with your environment's to work.

// increase timeout from default 10 seconds to 30 seconds
// to factor in the loading time to open Microsoft Word
timeout 30 seconds

// minimize window to show desktop and double-click document
click minimize_window.png
dclick letter_icon.png

// modify fields - can be hardcoded, repositories or datatables
dclick template_address.png
type page.png as John Lim[enter]123 ABC Street[enter]Singapore 123456789
keyboard [clear][clear][clear]

dclick template_name.png
type page.png as John

dclick template_amount.png
type page.png as $123.00

// click to print, then close document without saving changes
click file_menu.png
click print_menu.png
click confirm_button.png
click close_word.png
click dont_save.png

// This workflow shows printing of 1 letter from document template.
// Using TagUI datatables feature (csv file for batch automation),
// a large number of letters with different details can be printed.
