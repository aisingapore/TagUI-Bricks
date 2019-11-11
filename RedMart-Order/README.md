## RedMart.com - repeat or reschedule groceries order

This automation flow can be used to repeat or reschedule a groceries order on RedMart base on a previous order. RedMart has no way to repeat or reschedule an order besides manually clicking to add item by item from an old order.

![redmart_order.gif](https://raw.githubusercontent.com/aimakerspace/TagUI-Bricks/master/RedMart-Order/redmart_order.gif)

#### TagUI Workflow

```
// get URL of old groceries order to re-add all items to cart
ask Paste the URL of your groceries order and login to RedMart

// truncate to get address of URL without the https://
// JavaScript code can be used directly in TagUI workflows
ask_result = ask_result.substring(8)

// use https:// (or http://) step to visit URL of old order
https://`ask_result`

// loop for maximum 5 minutes for user to login to RedMart
for time_in_seconds from 1 to 300
{
    // indentation within code blocks in {} is optional

    // conditions can be in human language or JavaScript
    if time_in_seconds equals to 300
    {
        // use dom step to run JavaScript code on web browser
        dom alert('Quitting as groceries order page is not detected after 5 minutes')
        
        // terminate the automation workflow prematurely
        this.exit();
    }

    // XPath is a powerful way to identify webpage UI elements
    // intro to XPath - https://builtvisible.com/seo-guide-to-xpath

    // use present() function with XPath to check if logged in
    if present('(//*[@class="order-item"])[1]//*[@class="item-pic"]')
        break
    else
        wait 1 second
}

// get count of total items to place order for, using XPath identifier
total_items = count('//*[@class="order-item"]//*[@class="item-pic"]')

// to track total quantity of items to order
total_quantity = 0

// loop to add all the items and their quantity
for item from 1 to total_items
{
    // get count of quantity to order for item, before clicking into item
    read (//*[@class="order-item"])[`item`]//*[@class="item-quantity"]//*[@class="text"] to item_quantity
    click (//*[@class="order-item"])[`item`]//*[@class="item-pic"]

    // use hover step to wait for the ADD TO CART button to appear,
    // before checking if there is an Out of stock item description
    hover ADD TO CART
    if !present('Out of stock')
    {
        // handle case where item is in cart, thus no ADD TO CART button
        if present('next-icon-add')
            click next-icon-add
        else
            click ADD TO CART

        for additional_quantity from 2 to item_quantity
            click next-icon-add

        // wait to ensure adding of item has been registered before going back
        wait 3
        total_quantity = total_quantity + item_quantity
    }

    // go back to the previous page with list of items
    dom history.back()

    // optional wait to slow down the pace of iteration in the automation
    wait 3
}

// show popup with summary of the item and quantity count before exiting
// use dom_json variable and dom step to run JavaScript code in browser
dom_json = {total_items: total_items, total_quantity: total_quantity}
dom alert('A total quantity of ' + dom_json.total_quantity + ' items has been added to cart')
```

>This workflow was originally created in TagUI for Python (a Python package for RPA base on TagUI) and ported here. 
>https://github.com/tebelorg/TagUI-Python/issues/24
