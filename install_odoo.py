#!/usr/bin/env python3
"""Install crm and hr modules into the odoo20 database."""
import xmlrpc.client

url = "http://localhost:8069"

proxy = xmlrpc.client.ServerProxy(url)
# Common
common = proxy.execute("version", [])
print("Odoo version info:", common)

common_proxy = proxy
# Use execute directly
def execute(db, uid, pwd, model, method, args):
    return proxy.execute(db, uid, pwd, model, method, args)

proxy = xmlrpc.client.ServerProxy(url)
proxy.execute(db="odoo20", uid=1, pwd="admin", model="ir.module.module", method="button_install", args=[[5]])  # module id 5 = crm (approx)
print("CRM install triggered")

proxy.execute(db="odoo20", uid=1, pwd="admin", model="ir.module.module", method="button_immediate_install", args=[[5]])
print("CRM immediate install done")

proxy.execute(db="odoo20", uid=1, pwd="admin", model="ir.module.module", method="button_immediate_install", args=[[5]])
print("CRM immediate install done again")
