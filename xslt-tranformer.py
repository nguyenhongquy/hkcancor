#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan 17 21:53:32 2022

@author: quynguyen
"""

import lxml.etree as ET

dom = ET.parse('Cantonese.xml')

#%%
xslt = ET.parse('frequency.xslt')
transform = ET.XSLT(xslt)
newdom = transform(dom)
outHtm = str(newdom);
with open('frequency.htm', 'w') as f:
    f.write(outHtm);
 
#%%
xslt = ET.parse('examples.xslt')
transform = ET.XSLT(xslt)
newdom = transform(dom)
outHtm = str(newdom);
with open('examples.htm', 'w') as f:
    f.write(outHtm);
