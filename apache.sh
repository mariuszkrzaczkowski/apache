sudo apt-get update
sudo apt-get install apache2 libapache2-mod-fastcgi
  # enable php-fpm
sudo cp ~/.phpenv/versions/$(phpenv version-name)/etc/php-fpm.conf.default ~/.phpenv/versions/$(phpenv version-name)/etc/php-fpm.conf
sudo cp ~/.phpenv/versions/$(phpenv version-name)/etc/php-fpm.d/www.conf.default ~/.phpenv/versions/$(phpenv version-name)/etc/php-fpm.d/www.conf
sudo a2enmod rewrite actions fastcgi alias
echo "cgi.fix_pathinfo = 1" >> ~/.phpenv/versions/$(phpenv version-name)/etc/php.ini
~/.phpenv/versions/$(phpenv version-name)/sbin/php-fpm
  # configure apache virtual hosts
sudo cp -f build/travis-ci-apache /etc/apache2/sites-available/000-default
sudo sed -e "s?%TRAVIS_BUILD_DIR%?$(pwd)?g" --in-place /etc/apache2/sites-available/000-default
sudo service apache2 restart
sudo /etc/init.d/php-fpm restart    # typical
sudo /etc/init.d/php5-fpm restart   # debian-style
sudo /etc/init.d/php7.0-fpm restart # debian-style PHP 7
