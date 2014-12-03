Monitor script for nutcracker.
==============================

ballgazer.py inspects TwemProxy/nutcracker servers to help monitor its status and debug issues.

When run against a server with no pools specified, you will get all of the configured pools grouped as Active, inactive and broken.   The Broken pools are not neccassarily permanently broken, but have had bck end server ejection events.  It depends on how your pool is configured.  Membership to the Active or Inactive groups is just a function of the number of client connections the server has to that pool.


I use it like so:

    $ watch -d=cumulative ./ballgazer.py myhost.mydomain.com

The output looks like:

    Every 2.0s: ./ballgazer.py app06.scrippsing.com           Fri Jan 25 16:23:01 2013

    app06.scrippsing.com:22222
    ==========================
        source : app06.mydomain.com
        uptime : 313
       version : 0.2.2
       service : nutcracker
     timestamp : 1359148981


    Broken (backends/connections/server_ejections)
    ==============================================
                  ABIL.MOBILE ( 5/4/33 ) !
             ABIL.MOBILE_back ( 5/4/26 ) !
               AIM.OAW.MOBILE ( 5/4/38 ) !
          AIM.OAW.MOBILE_back ( 5/4/36 ) !
                   GVE.MOBILE ( 5/4/45 ) !
              GVE.MOBILE_back ( 5/4/42 ) !
                  SAST.MOBILE ( 5/4/27 ) !
             SAST.MOBILE_back ( 5/4/20 ) !



    Active (backends/connections/server_ejections)
    ==============================================
                         ABIL ( 5/10/0 )
                    ABIL_back ( 5/10/0 )
                          AIM ( 5/13/0 )
                     AIM_back ( 5/13/0 )
                          AVP ( 5/5/0 )
                     AVP_back ( 5/5/0 )
                         BLNT ( 5/4/0 )
                    BLNT_back ( 5/4/0 )



    Unused (backends/connections/server_ejections)
    ==============================================
                  BLNT.MOBILE ( 5/0/0 )
             BLNT.MOBILE_back ( 5/0/0 )
                     BSUN.TSL ( 5/0/0 )
                BSUN.TSL_back ( 5/0/0 )
                         BTOP ( 5/0/0 )
                    BTOP_back ( 5/0/0 )
                         DRMN ( 5/0/0 )
                    DRMN_back ( 5/0/0 )
             NPDN.VSEM.MOBILE ( 5/0/0 )


When there are issues spotted:

    $ watch -d=cumulative ./ballgazer.py myhost.mydomain.com MY_CACHEGROUP



