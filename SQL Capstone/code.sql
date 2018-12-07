--distinct campaigns--
SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;

--distinct sources--
SELECT COUNT(DISTINCT utm_source)
FROM page_visits;

--relationship--
SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;

--pages on website—
SELECT DISTINCT page_name
FROM page_visits;


--total first touches--
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
        pv.utm_campaign,
        COUNT(utm_campaign)
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
    GROUP BY utm_campaign
ORDER BY 5 DESC;


--total last touches--
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
        pv.utm_campaign,
        COUNT(utm_campaign)
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
    GROUP BY utm_campaign
ORDER BY 5 DESC;


--how many visitors made purchase--
SELECT COUNT(DISTINCT user_id),
page_name
FROM page_visits
WHERE page_name = '4 - purchase';


--last touches on the purchase page--
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
        pv.utm_campaign,
        COUNT(utm_campaign)
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
    WHERE page_name = '4 - purchase'
    GROUP BY utm_campaign
ORDER BY 5 DESC;
