<?php

namespace PHPMailer\PHPMailer;

// Use mailhog to receive mail locally, http://localhost:8025
add_action( 'phpmailer_init', function ( PHPMailer $phpmailer ) {
	$phpmailer->Host = 'mailhog';
	$phpmailer->Port = 1025;
	$phpmailer->IsSMTP();
} );