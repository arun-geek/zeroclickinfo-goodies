#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Goodie;
use utf8;

zci answer_type => 'sun_info';
zci is_cached   => 0;

# Presume sun will rise in the morning and set at night year round in PA.
my @now = (qr/^On.*Phoenixville, Pennsylvania.*AM.*PM\.$/, 
    structured_answer => {
        id => 'sun_info',
        name => 'Answer',
        data => '-ANY-',
        templates => {
            group => 'text',
            item => 0,
            options => {
                content => 'DDH.sun_info.content'
            }
        }
    }
);
my @aug = (qr/^On 30 Aug.*AM.*PM\.$/, 
    structured_answer => {
        id => 'sun_info',
        name => 'Answer',
        data => '-ANY-',
        templates => {
            group => 'text',
            item => 0,
            options => {
                content => 'DDH.sun_info.content'
            }
        }
    }
);
my @exact = (
    'On 01 Jan 2015, sunrise in Phoenixville, Pennsylvania is at 7:23 AM; sunset at 4:46 PM.',
    structured_answer => {
        id => 'sun_info',
        name => 'Answer',
        data => {                                                                                                                                       
            rise => "7:23 AM",                                                                                                                        
            set_data => "4:46 PM",                                                                                                                        
            sunrise_svg => "/share/goodie/sun_info/999/sunrise.svg",                                                                                         
            sunset_svg => "/share/goodie/sun_info/999/sunset.svg",                                                                                          
            when_data => "01 Jan 2015",                                                                                                                    
            where => "Phoenixville, Pennsylvania"                                                                                                      
        },
        templates => {
            group => 'text',
            item => 0,
            options => {
                content => 'DDH.sun_info.content'
            }
        }
    }
);

ddg_goodie_test(
    [qw( DDG::Goodie::SunInfo )],
    'sunrise'                             => test_zci(@now),
    'what time is sunrise'                => test_zci(@now),
    'sunset'                              => test_zci(@now),
    'what time is sunset'                 => test_zci(@now),
    'sunrise for aug 30'                  => test_zci(@aug),
    'sunrise 30 aug'                      => test_zci(@aug),
    'sunset for aug 30?'                  => test_zci(@aug),
    'sunset aug 30th'                     => test_zci(@aug),
    'sunset on 2015-01-01'                => test_zci(@exact),
    'what time is sunrise on 2015-01-01?' => test_zci(@exact),
    'January 1st, 2015 sunrise'           => test_zci(@exact),
    q{sunrise at 39°57'N 5°10'W}          => test_zci(qr"On.*Coordinates .*AM.*PM", 
        structured_answer => {
            id => 'sun_info',
            name => 'Answer',
            data => '-ANY-',
            templates => {
                group => 'text',
                item => 0,
                options => {
                    content => 'DDH.sun_info.content'
                }
            }
        }
    ),
    'sunset at 1S 1W' => test_zci(qr"On .*, sunrise in Coordinates -1°N -1°E is at .*AM; sunset at .*PM.",
        structured_answer => {
            id => 'sun_info',
            name => 'Answer',
            data => '-ANY-',
            templates => {
                group => 'text',
                item => 0,
                options => {
                    content => 'DDH.sun_info.content'
                }
            }
        }
    ),
    'sunset at 53N 2E on 2014-01-01' => test_zci("On 01 Jan 2014, sunrise in Coordinates 53°N 2°E is at 8:05 AM; sunset at 3:46 PM.",
        structured_answer => {
            id => 'sun_info',
            name => 'Answer',
            data => '-ANY-',
            templates => {
                group => 'text',
                item => 0,
                options => {
                    content => 'DDH.sun_info.content'
                }
            }
        }
    ),
    'sunset at 53N 2W on 2014-01-08' => test_zci("On 08 Jan 2014, sunrise in Coordinates 53°N -2°E is at 8:18 AM; sunset at 4:11 PM.",
        structured_answer => {
            id => 'sun_info',
            name => 'Answer',
            data => '-ANY-',
            templates => {
                group => 'text',
                item => 0,
                options => {
                    content => 'DDH.sun_info.content'
                }
            }
        }
    ),
    'sunset for philly' => undef,
    'sunrise on mars'   => undef,
    'sunset boulevard'  => undef,
    'tequila sunrise'   => undef,
    'sunrise mall'      => undef,
    'after the sunset'  => undef,
);

done_testing;
