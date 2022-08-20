<?php

// Disable deprecation notices
if ( WP_DEBUG ) {
	error_reporting( E_ALL & ~E_DEPRECATED );
}