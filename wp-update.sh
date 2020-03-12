#path to WordPress installations
SITESTORE=~/../home

#create array of sites based on folder names
SITELIST=($(ls -lh $SITESTORE | awk '{print $9}'))

#start the loop
for SITE in ${SITELIST[@]};
do
    echo Updating in $SITE
    #enter the WordPress folder
    cd $SITESTORE/$SITE/public_html
    wp plugin update --all --allow-root;
    ## untested theme update
    wp theme update --all;
    wp core update;
done

#Fix permissions
sudo chown -R www-data:www-data $SITESTORE
sudo find $SITESTORE -type f -exec chmod 644 {} +
sudo find $SITESTORE -type d -exec chmod 755 {} +
