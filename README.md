# TABC: CR (Compliance Reporting)

## Former Names

* Retail Compliance Reporting (RCR)
* Self Inspection (SI)
* Audit

## Deploying

    > bin/deploy sandbox
    > bin/deploy production

## Data Feed

The data feed includes "vendor" info. This info is split into three groups:

* owner-related
* location-related
* license-related

### Owner-Related

The `companies` table contains all owner-related info. Current fields are:

* `owner_id`

### Location-Related

The `locations` table contains all location-related info. Current fields are:

* `name`
* `address1`
* `address2`
* `address3`
* `city`
* `county`
* `state`
* `country`
* `postal_code`

### License-Related

The `licenses` table contains all license-related info. Current fields are:

* `license_type`
* `license_number`
* `subordinate`
* `related_to`
