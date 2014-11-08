dataSource {
    pooled = true
}

hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
    validator.apply_to_ddl = false 
    validator.autoregister_listeners = false 
}
// environment specific settings
environments {
    development {
        dataSource {
        }
    }
    test {
        dataSource {
        }
    }
    production {
        dataSource {
            dialect = "org.hibernate.dialect.PostgreSQLDialect"
            driverClassName = "org.postgresql.Driver"
            //jndiName = "java:jboss/datasources/DevSAC"
            properties {
                maxActive = 150
                maxIdle = 25
                minIdle = 1
                initialSize = 5
                maxWait = 60000
                testOnBorrow = true
                testOnReturn = true
                testWhileIdle = false
                minEvictableIdleTimeMillis = (1000 * 60)
                timeBetweenEvictionRunsMillis = (1000 * 60)
                numTestsPerEvictionRun=3
                validationQuery="SELECT 1"
            }
        }
    }
}
