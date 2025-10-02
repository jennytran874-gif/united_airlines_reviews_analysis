WITH base AS (
  SELECT
    CABIN_STAFF_SERVICE,
    FOOD_AND_BEVERAGES,
    GROUND_SERVICE,
    INFLIGHT_ENTERTAINMENT,
    SEAT_COMFORT,
    WIFI_AND_CONNECTIVITY,
    VALUE_FOR_MONEY
  FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW_ENRICHED
  WHERE AIRLINE = 'United Airlines' AND SEAT_TYPE = 'Economy Class'
),
corr_upper AS (
  -- diagonals
  SELECT 'Cabin Staff Service'       AS metric_x, 'Cabin Staff Service'       AS metric_y, 1.0::FLOAT AS correlation UNION ALL
  SELECT 'Food and Beverages',              'Food and Beverages',                    1.0::FLOAT UNION ALL
  SELECT 'Ground Service',                   'Ground Service',                       1.0::FLOAT UNION ALL
  SELECT 'Inflight Entertainment',           'Inflight Entertainment',               1.0::FLOAT UNION ALL
  SELECT 'Seat Comfort',                     'Seat Comfort',                         1.0::FLOAT UNION ALL
  SELECT 'WiFi and Connectivity',            'WiFi and Connectivity',                1.0::FLOAT UNION ALL
  SELECT 'Value for Money',                  'Value for Money',                      1.0::FLOAT

  UNION ALL
  -- unique off-diagonal pairs (upper triangle)
  SELECT 'Cabin Staff Service','Food and Beverages',        CORR(CABIN_STAFF_SERVICE, FOOD_AND_BEVERAGES)        FROM base UNION ALL
  SELECT 'Cabin Staff Service','Ground Service',            CORR(CABIN_STAFF_SERVICE, GROUND_SERVICE)            FROM base UNION ALL
  SELECT 'Cabin Staff Service','Inflight Entertainment',    CORR(CABIN_STAFF_SERVICE, INFLIGHT_ENTERTAINMENT)    FROM base UNION ALL
  SELECT 'Cabin Staff Service','Seat Comfort',              CORR(CABIN_STAFF_SERVICE, SEAT_COMFORT)              FROM base UNION ALL
  SELECT 'Cabin Staff Service','WiFi and Connectivity',     CORR(CABIN_STAFF_SERVICE, WIFI_AND_CONNECTIVITY)     FROM base UNION ALL
  SELECT 'Cabin Staff Service','Value for Money',           CORR(CABIN_STAFF_SERVICE, VALUE_FOR_MONEY)           FROM base UNION ALL

  SELECT 'Food and Beverages','Ground Service',             CORR(FOOD_AND_BEVERAGES, GROUND_SERVICE)             FROM base UNION ALL
  SELECT 'Food and Beverages','Inflight Entertainment',     CORR(FOOD_AND_BEVERAGES, INFLIGHT_ENTERTAINMENT)     FROM base UNION ALL
  SELECT 'Food and Beverages','Seat Comfort',               CORR(FOOD_AND_BEVERAGES, SEAT_COMFORT)               FROM base UNION ALL
  SELECT 'Food and Beverages','WiFi and Connectivity',      CORR(FOOD_AND_BEVERAGES, WIFI_AND_CONNECTIVITY)      FROM base UNION ALL
  SELECT 'Food and Beverages','Value for Money',            CORR(FOOD_AND_BEVERAGES, VALUE_FOR_MONEY)            FROM base UNION ALL

  SELECT 'Ground Service','Inflight Entertainment',         CORR(GROUND_SERVICE, INFLIGHT_ENTERTAINMENT)         FROM base UNION ALL
  SELECT 'Ground Service','Seat Comfort',                   CORR(GROUND_SERVICE, SEAT_COMFORT)                   FROM base UNION ALL
  SELECT 'Ground Service','WiFi and Connectivity',          CORR(GROUND_SERVICE, WIFI_AND_CONNECTIVITY)          FROM base UNION ALL
  SELECT 'Ground Service','Value for Money',                CORR(GROUND_SERVICE, VALUE_FOR_MONEY)                FROM base UNION ALL

  SELECT 'Inflight Entertainment','Seat Comfort',           CORR(INFLIGHT_ENTERTAINMENT, SEAT_COMFORT)           FROM base UNION ALL
  SELECT 'Inflight Entertainment','WiFi and Connectivity',  CORR(INFLIGHT_ENTERTAINMENT, WIFI_AND_CONNECTIVITY)  FROM base UNION ALL
  SELECT 'Inflight Entertainment','Value for Money',        CORR(INFLIGHT_ENTERTAINMENT, VALUE_FOR_MONEY)        FROM base UNION ALL

  SELECT 'Seat Comfort','WiFi and Connectivity',            CORR(SEAT_COMFORT, WIFI_AND_CONNECTIVITY)            FROM base UNION ALL
  SELECT 'Seat Comfort','Value for Money',                  CORR(SEAT_COMFORT, VALUE_FOR_MONEY)                  FROM base UNION ALL

  SELECT 'WiFi and Connectivity','Value for Money',         CORR(WIFI_AND_CONNECTIVITY, VALUE_FOR_MONEY)         FROM base
),
corr_full AS (
  SELECT metric_x, metric_y, correlation FROM corr_upper
  UNION ALL
  -- mirror to get the lower triangle
  SELECT metric_y AS metric_x, metric_x AS metric_y, correlation
  FROM corr_upper
  WHERE metric_x <> metric_y
)
SELECT metric_x, metric_y, correlation
FROM corr_full
ORDER BY metric_x, metric_y;
