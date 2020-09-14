""" from AIM photonics edx course
"""

import numpy as np


def delta_index(dn, dp):
    return -5.4e-22 * dn ** 1.011 - 1.53e-18 * dp ** 0.838


def test_delta_index():
    dn = delta_index(1e17, 1e17)
    assert np.isclose(dn, -0.00035264268567734245)
    dn = delta_index(1e18, 1e18)
    assert np.isclose(dn, -0.0027083950268490574)


def delta_alpha(dn, dp):
    return 10


if __name__ == "__main__":
    dn = delta_index(5e17, 0)
    print(dn)
