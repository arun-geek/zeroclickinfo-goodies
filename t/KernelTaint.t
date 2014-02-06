#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Goodie;

zci answer_type => 'kernel_taint';

ddg_goodie_test(
	[qw(
		DDG::Goodie::KernelTaint
	)],
	'kernel taint 5121' => test_zci('A module with a non-GPL license has been loaded, this includes modules with no license. Set by modutils >= 2.4.9 and module-init-tools.
A module from drivers/staging was loaded.
An out-of-tree module has been loaded.', html => 'A module with a non-GPL license has been loaded, this includes modules with no license. Set by modutils >= 2.4.9 and module-init-tools.<br>A module from drivers/staging was loaded.<br>An out-of-tree module has been loaded.<br><a href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/sysctl/kernel.txt">Documentation</a>'),
	'/proc/sys/kernel/tainted 2' => test_zci('A module was force loaded by insmod -f. Set by modutils >= 2.4.9 and module-init-tools.', html => 'A module was force loaded by insmod -f. Set by modutils >= 2.4.9 and module-init-tools.<br><a href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/sysctl/kernel.txt">Documentation</a>'),
	'2 kernel taint' => test_zci('A module was force loaded by insmod -f. Set by modutils >= 2.4.9 and module-init-tools.', html => 'A module was force loaded by insmod -f. Set by modutils >= 2.4.9 and module-init-tools.<br><a href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/sysctl/kernel.txt">Documentation</a>')
);

done_testing;
