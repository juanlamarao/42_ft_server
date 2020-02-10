<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wordpressuser' );

/** MySQL database password */
define( 'DB_PASSWORD', 'juolivei' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define('FS_METHOD', 'direct');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '8wc|MYxM3xyq1jGuTqRLG2,.n.6ZKxOeFq^aU?1ei+[cZ``x1k~!jfA^?z]W%oTp' );
define( 'SECURE_AUTH_KEY',  '8!ODJzgB7Lc,e7<Cy>uj6Y[b/RZ0v2DhjT]^lGnnheth4Of&*44KH<pTx,/-C?)I' );
define( 'LOGGED_IN_KEY',    '>96G+SErg@4Vn+>;g 6aGhJgo/-j`y*`P!;?Tl$UOBRK;kJ@c+]U%%{]csxuCz7|' );
define( 'NONCE_KEY',        'ekCagAi0,snfivK3r|Q]V{%V_a&LL3|l(w]ig!%n,$OA~z:%i|4W>mC(Za1DnHzM' );
define( 'AUTH_SALT',        '[8S^g}]2?6FoDRi2V29[@3Ol|r,YB2RAA$Hl0-kSXoqU?&h9Mgt2Xc{hyQDCr 2e' );
define( 'SECURE_AUTH_SALT', 'wM5z:+V55Q/U;1zj^<l]+PQ5y,WVSd_l+y*!r3ieiwSX.x#aDSwV)[BS:kY# !+a' );
define( 'LOGGED_IN_SALT',   'Ja X5MP}Krc|9 sws.!oFq`9$)zBFoJ|fx/UdQK>,M;,1Z;r{+/Ky^<v%FdVrQNn' );
define( 'NONCE_SALT',       'd;>vP{DJ`A]Gh9Ov%Bw;Z/yZBrp6tdZ><570E@tk?dI|$WyiRs7rq<9#-@hH1|}&' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
