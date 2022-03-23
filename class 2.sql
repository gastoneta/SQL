use imdb;

CREate table  film 
(film_id int AUTO_INCREMENT PRIMARY KEY ,
  title VARCHAR ( 30 ) ,
  description VARCHAR ( 30 ) ,
  release_year INT 
);

create table actor
(actor_id int AUTO_INCREMENT PRIMARY KEY ,
first_name varchar (25) ,
last_name varchar (25)
);


create table film_actor
(actor_id int ,
film_id int ,
FOREIGN KEY (actor_id) REFERENCES actor(actor_id) ,
FOREIGN KEY (film_id) REFERENCES film(film_id)
);

