# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.14.7
# ---

# # Thermo-optic switch
#
#  Thermo-optic switch based on a Mach Zehnder Interferometer
# Consider a thermo-optic switch based on a balanced MZI. The switch consists of
# two Y branches connected with identical waveguides. One of the waveguides is
# covered with a metal heater, which is attached to two electrical probe pads.

# +

import numpy as np

L = 100
w = 1.55
dndt = 2e-4


# B*L = np.pi

B = np.pi/L

# B = 2*pi(n+dndt*dt)/w
# the first part is common for both arms, dB = 2*pi*dndt*dt/w
dt = w*dB/(2*np.pi*dndt)
dt = 38.75

