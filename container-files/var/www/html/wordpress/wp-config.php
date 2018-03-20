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
define('DB_NAME', (($_SERVER['MYSQL_DATABASE']) ? $_SERVER['MYSQL_DATABASE'] : 'wordpress'));

/** MySQL database username */
define('DB_USER', (($_SERVER['MYSQL_USER'])?$_SERVER['MYSQL_USER']:'froot'));

/** MySQL database password */
define('DB_PASSWORD', (($_SERVER['MYSQL_PASSWORD'])? $_SERVER['MYSQL_PASSWORD']: 'froot'));

/** MySQL hostname */
define('DB_HOST', (($_SERVER['DATABASE_HOST'])? $_SERVER['DATABASE_HOST']:'mysql'));

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8mb4');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/** 
* Enable setting the default theme to something other than twentyseventeen.
* Of course, this requires that theme be downloaded and available. 
* Currently using the "School" theme.
*/
// define('WP_DEFAULT_THEME', 'school');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '2|x]Oq&+_XWsf--ZS;uK}li))h+6I1sCK.,R>Thi63Dd9U~HJDVUFn1Z8]U}OC$6');
define('SECURE_AUTH_KEY',  '>A>iV K/rcLE}$@B`6U<qT;w1+hI72Zea5!E_U{Gla[@y1t<PZ-rpeM,3Sx()BLC');
define('LOGGED_IN_KEY',    'Fn{-=o<Q5V*K 1cxll~4#8*y^ d%zrlEUOs]2kb,Wx|,r9sUGCh2hhiA]+$(+_Jq');
define('NONCE_KEY',        'wCwIBWj|LOpWcsREDp#[LH&7aF(LL%gTDoUpb*+=Ez(FWF>y/{E)f[]_p%*+(J>q');
define('AUTH_SALT',        '#f#!tkXAy39s&U7f=Vh-ey+9lCf%aNy(ugK&`s-m_CJ{RxW+JO%=wzU~AL-5wB,4');
define('SECURE_AUTH_SALT', '*;iHCkm)C>g0N1*wwJBu;OmQ6^{ZY;{S-m}JI[d8_h&d%e|L;h3Jcd?`9Ix2-R2w');
define('LOGGED_IN_SALT',   'w%9gKAQ|!,mN{@aEB_sFf%#uaSk|^,TRmV+ XK40@E-UFVL)Zg&nD8Opv7@nr~4A');
define('NONCE_SALT',       '3Qg7|MMAxpA){-hd5A:>3 @*sMpicmZRa~{yTAU8u_=d]B/$ig q&Hg#D`JWJ)(|');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = (($_SERVER['DATABASE_PREFIX'])? $_SERVER['DATABASE_PREFIX'] : 'wp_');

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
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

/** Sets up "direct method for WP auto-update w/o FTP*/
define('FS_METHOD', 'direct');

/** Default the lanuage to US English **/
define('WPLANG', 'en_us');


// Clean up after ourselves.
// unset($_SERVER['MYSQL_DATABASE']);
// unset($_SERVER['MYSQL_USER']);
// unset($_SERVER['MYSQL_PASSWORD']);
