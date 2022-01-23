# Shopify Backend Developer Challenge inventoryTracker
Inventory Tracking application for [Shopify Backend Developer Challenge for Summer 2022](https://docs.google.com/document/d/1z9LZ_kZBUbg-O2MhZVVSqTmvDko5IJWHtuFmIu_Xg1A/edit)

Check out the app [here](https://boiling-harbor-00476.herokuapp.com/)

## Overview 

**InventoryTracker** is a localized repository for tracking inventory. Users are able to create an account, and 
- Create inventory items
- Edit Them
- Delete Them
- View a list of them


Each item posting allows a **title**, a **description**, **price** and **count** selection. By using the navbar at the top of the page, users can view all items in the system, only items created by them or create new items.

## Main Feature

The feature chosen for this challenge was ***image upload***.
> Allow image uploads AND store image with generated thumbnails

Each item posting allows for an image field which is done using Ruby on Rails native **ActiveStorage** class.
This allows us to upload images directly to any cloud storage platform as well as resize and transform images.

In the application we upload images directly to Amazon S3 with the following configuration in the `config/storage.yml` file
```
amazon:
  service: S3
  access_key_id: ""
  secret_access_key: ""
  region: ""
  bucket: ""
```

We also create smaller image variants when displaying images in the table with ActiveStorage variant functionality
```
 <%= image_tag item.photo.representation(resize_to_limit: [100, 100], saver: { subsample_mode: "on", strip: true, interlace: true, quality: 70 }).processed.url %>
```

For image processing in the application we are using **libvips**, because it is [up to 10x faster and consumes 1/10 the memory](https://github.com/libvips/libvips/wiki/Speed-and-memory-use) of the default ImageMagick library.



## Running Locally
To run locally we need to add the following to the `.env` file

```
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
S3_BUCKET=
AWS_REGION=
TEST_DATABASE_NAME=
TEST_DATABASE_USER=
TEST_DATABASE_HOST=
TEST_DATABASE_PASS=
DEV_DATABASE_NAME=
DEV_DATABASE_USER=
DEV_DATABASE_HOST=
DEV_DATABASE_PASS=
```

Install ruby "3.0.3" and  rails "7.0.0"

and run the server with 
```
rails s
```

## Development 

- Ruby on Rails
- PostgreSQL

## Future Imporvements
- [x] Implement user management
- [x] Add image upload
- [ ] Add categories to items
- [ ] Allow for a search 
