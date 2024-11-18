--Fetch the top 10 videos having more number of views.--
SELECT
  name,
  no_of_views
FROM
  video
ORDER BY
  no_of_views DESC,
  name ASC
LIMIT
  10;
-- Get all the review videos i.e., videos which contain "review" in their name.
SELECT
  name,
  no_of_views
FROM
  video
WHERE
  name LIKE "%review%"
ORDER BY
  no_of_views DESC;
--Get the total number of channels in the database.--
SELECT
  count(channel_id) AS no_of_channels
FROM
  channel;
--Get all the music videos released before the year 2016.--
SELECT
  name,
  no_of_views,
  cast(strftime("%Y", published_datetime) AS INTEGER) AS year
FROM
  video
WHERE
  name LIKE "%music%"
  AND cast(strftime("%Y", published_datetime) AS INTEGER) < 2016
ORDER BY
  year DESC,
  name ASC;
--Get the total number of countries where the users of the platform are present.--
SELECT
  count(DISTINCT country) AS country_count
FROM
  user;
--Find the number of videos published between the years 2010 & 2016.--
SELECT
  cast(strftime("%Y", published_datetime) AS INTEGER) AS year,
  COUNT(video_id) AS no_of_videos
FROM
  video
GROUP BY
  year
HAVING
  year BETWEEN 2010
  AND 2016
ORDER BY
  year ASC;
--Fetch the top 10 videos having more number of views, along with the channel details.--
SELECT
  video.name AS video_name,
  no_of_views,
  channel.name AS channel_name
FROM
  video
  INNER JOIN channel ON channel.channel_id = video.channel_id
ORDER BY
  no_of_views DESC,
  channel_name ASC
LIMIT
  10;
--Get all the unique channels that published review videos.--
SELECT
  channel.channel_id,
  channel.name AS channel_name
FROM
  channel
  INNER JOIN video ON channel.channel_id = video.channel_id
WHERE
  video.name LIKE "%review%"
GROUP BY
  channel.channel_id
ORDER BY
  channel_name ASC;
--Get all the videos that belong to "Action" genre (genre_id = 201) and have more than 1 lakh views.--
SELECT
  video.video_id,
  video.name,
  video_genre.genre_id
FROM
  video
  INNER JOIN video_genre ON video.video_id = video_genre.video_id
WHERE
  video_genre.genre_id = 201
  AND video.no_of_views > 100000
ORDER BY
  video.video_id ASC;
--Get the total number of users subscribed for the channel "Tyler Oakley" (channel_id = 376) in the year 2018.--
SELECT
  count(channel_id) AS no_of_subscribers
FROM
  channel_user
WHERE
  channel_id = 376
  AND cast(strftime("%Y", subscribed_datetime) AS INTEGER) = 2018;
--Get the geographic distribution of Taylor Swift channel (channel_id = 399) subscribers.--
SELECT
  user.country,
  count(premium_membership) AS no_of_subscribers
FROM
  user
  INNER JOIN channel_user ON user.user_id = channel_user.user_id
WHERE
  channel_user.channel_id = 399
GROUP BY
  user.country
ORDER BY
  user.country ASC;
--Between 2010 & 2020, find the number of videos released in each of the below genres.--
SELECT
  genre.genre_id,
  count(video_genre.video_id) AS no_of_videos
FROM
  genre
  INNER JOIN video_genre ON genre.genre_id = video_genre.genre_id
  INNER JOIN video ON video.video_id = video_genre.video_id
WHERE
  video_genre.genre_id IN (201, 202, 204, 205, 206, 207)
  AND cast(strftime("%Y", published_datetime) AS INTEGER) BETWEEN 2010
  AND 2020
GROUP BY
  genre.genre_id
ORDER BY
  no_of_videos DESC,
  genre.genre_id ASC;
--Get all the Indian users details whose age is below 30 years and liked the video (video_id = 1011) in the year 2020.--
SELECT
  user.name,
  user.gender,
  user.age,
  user.country,
  user.premium_membership
FROM
  user
  INNER JOIN user_likes ON user.user_id = user_likes.user_id
WHERE
  user_likes.video_id = 1011
  AND user.country LIKE "%INDIA%"
  AND user.age < 30
  AND user_likes.reaction_type LIKE "LIKE"
  AND cast(strftime("%Y", reacted_at) AS INTEGER) = 2020
ORDER BY
  user.name ASC;
--Get the total number of countries where the subscribers of the Taylor Swift channel (channel_id = 399) are present.--
SELECT
  count(DISTINCT country) AS country_count
FROM
  user
  INNER JOIN channel_user ON user.user_id = channel_user.user_id
WHERE
  channel_user.channel_id = 399;
--Get all distinct channels which published music videos before 2016.--
SELECT
  channel.channel_id,
  channel.name AS channel_name
FROM
  channel
  INNER JOIN video ON channel.channel_id = video.channel_id
WHERE
  video.name LIKE "%music%"
  AND cast(strftime("%Y", published_datetime) AS INTEGER) < 2016
GROUP BY
  channel.channel_id
ORDER BY
  channel_name ASC;
