# This file is specifically for you to define your strategies 
#
# You should declare you strategies directly and/or use 
# Merb::Authentication.activate!(:label_of_strategy)
#
# To load and set the order of strategy processing

MerbAuthSlicePassword[:no_default_strategies] = true
Merb::Authentication.activate!(:default_openid)
