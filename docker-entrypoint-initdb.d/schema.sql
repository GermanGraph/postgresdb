CREATE EXTENSION IF NOT EXISTS hstore;


CREATE TABLE public.video
(
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL CHECK (title != ''),
    path VARCHAR(255) NOT NULL,
    youtube_url VARCHAR(255),
    duration INT NOT NULL,
    size POINT NOT NULL,
    fps INT NOT NULL
);
CREATE UNIQUE INDEX table_name_path_uindex ON public.video (path);


CREATE TABLE public.feature
(
    id SERIAL PRIMARY KEY,
    video_id INT NOT NULL,
    pos BOX NOT NULL,
    image VARCHAR(255) NOT NULL CHECK (image != ''),
    frames INT ARRAY CHECK (
        array_length(frames, 1) = 2
        AND frames[1] <= frames[2]
    ),
    info HSTORE DEFAULT hstore(''),
    CONSTRAINT feature_video_id_fk FOREIGN KEY (video_id) REFERENCES video (id)
);


CREATE TABLE public.dubbing
(
    id SERIAL PRIMARY KEY,
    video_id INT NOT NULL,
    text TEXT,
    frames INT ARRAY NOT NULL CHECK (
        array_length(frames, 1) = 2
        AND frames[1] <= frames[2]
    ),
    info HSTORE DEFAULT hstore('') NOT NULL,
    CONSTRAINT dubbing_video_id_fk FOREIGN KEY (video_id) REFERENCES video (id)
);

