# Order Tracker

Make a fabulous order tracker for you e-commerce app is no time.

#### Showcase

![Untitled](https://user-images.githubusercontent.com/102783954/230720601-5ccb5f58-b675-470a-ab4c-154cb22113ad.gif)

### What is different

| Title                                                       | Other Order Tackers | Order Tracker Zen |
| ----------------------------------------------------------- | ------------------- | ----------------- |
| Order Tracking Functionality                                | ✅                  | ✅                |
| Animations                                                  | ✅                  | ✅                |
| Custom Order Headings                                       | 👎🏻                  | ✅                |
| Use Custom Styles                                           | 👎🏻                  | ✅                |
| Toggle bitween expanded and shrinked just with one variable | 👎🏻                  | ✅                |
| Email Support By Zenzzen                                    | 👎🏻                  | ✅                |
| Shrinkable                                                  | 👎🏻                  | ✅                |

**Our team is always happy to help tech enthusiasts like you, you can email us on dev_support@zenzzen.com in case if you find any difficulty**

## How to get started❓ 🤔

You can simply add the dependency from **cli** like:

    flutter pub add order_tracker_zen

**Or** you can add it in your **pubspec.yaml** like:

    dependencies:
    	order_tracker_zen:

## How to use❓ 🤔

Using it is as **easy as** create a **TextFormField**, Don't beleave? Let me show you:

```
OrderTrackerZen(
	tracker_data: [
		TrackerData(
			title: "Order Place",
			date: "Sat, 8 Apr '22",
			tracker_details: [
				TrackerDetails(
					title: "Your order was placed on Zenzzen",
					datetime: "Sat, 8 Apr '22 - 17:17",
				),
				TrackerDetails(
					title: "Zenzzen Arranged A Callback Request",
					datetime: "Sat, 8 Apr '22 - 17:42",
				),
			],
		),
		TrackerData(
			title: "Order Shipped",
			date: "Sat, 8 Apr '22",
			tracker_details: [
				TrackerDetails(
					title: "Your order was shipped with MailDeli",
					datetime: "Sat, 8 Apr '22 - 17:50",
				),
			],
		),
		TrackerData(
			title: "Order Delivered",
			date: "Sat,8 Apr '22",
			tracker_details: [
				TrackerDetails(
					title: "You received your order, by MailDeli",
					datetime: "Sat, 8 Apr '22 - 17:51",
				),
			],
		),
	],
)
```

**Looks Looooong?** Dont worrrrrryyyyy.....
This is because it hardcoded data, in your case you must be using loops here. Ok!

**Let me explain about `OrderTrackerZen`, `TrackerData` and `TrackerDetails` .**

- `OrderTrackerZen` is main container of whole order tracker, like
  <img width="487" alt="image" src="https://user-images.githubusercontent.com/102783954/230720647-97dad7f5-fcb7-4c8f-9f26-e3ac04e94bf6.png">

- `TrackerData` is container of that contains tracking details
  <img width="487" alt="image" src="https://user-images.githubusercontent.com/102783954/230720666-9d501e90-a119-4847-a936-350d0d2afe8d.png">

- `TrackerDetails` is a single tracking tracking detail
  <img width="487" alt="image" src="https://user-images.githubusercontent.com/102783954/230720673-817fd477-aff6-42a5-8398-210da9ecebd6.png">

## Additional Params (Optional)

- `success_color` : Color of progress bar
- `background_color` : Background color of progress bar
- `screen_background_color` : Dot in progress bar has a small border, that must match background, that helps in same
- `text_primary_color` : Primary text color
- `text_secondary_color` : Seconday text color
- `isShrinked` : This boolean toggles bitween shrinked and detailed view

**This is what Zenzzen Team made for you specially 😊, Now it's your responsibility to make ground-breaking app that rocks 🤘🏻**
