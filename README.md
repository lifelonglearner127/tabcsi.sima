# TABC: SI (Self-Inspection, a.k.a. Audit)

## Deploying

    > bin/deploy sandbox
    > bin/deploy production

## Vendor Associations

The `vendors` table is a source table. What this means is that `licenses` and
`locations` act as proxies. Vendors essentially represent licenses/permits, but
there's location data associated with them as well. This location data is
repetitive; in the future, the relationships between these tables may become
more succinct.

The "location-vendor" relationship is interesting in that a vendor belongs to a
location, but the location proxies to the vendor. The reason this "chicken-egg"
problem can work is because a location represents a physical, addressable
location; e.g., a bar or convenient store. This means the location only needs to
proxy to the first vendor in the `vendors` association.

The "license-vendor" relationship is simple and straightforward. Since a vendor
is essentially a license/permit, a license only needs to belong to a single
`vendor`, and thus a vendor only needs to have one `license`.
