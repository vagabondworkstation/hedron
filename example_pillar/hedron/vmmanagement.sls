# Do not set to false! Unset key entirely!
# This has been removed, at least for now.
{% if grains['id'] == 'vmmanagement-super-special-host-1' %}
hedron_vmmanagement_custom_networking: True
{% endif %}
# If you set one, you must set all, unfortunately. It's a bit of a bug.
hedron.vmmanagement.address_btc: 1aaaa
hedron.vmmanagement.address_bch: bitcoincash:qqq
hedron.vmmanagement.address_bsv: 1aaaa
# This is very hacky.
# When vmmanagement.json is switched to file.serialize, this should be switched to a proper dict.
hedron.vmmanagement.monero_rpc: '{"host": "somerpchost", "port": 1337, "user": "someuser", "password": "somepassword"}'
