SELECT * FROM Book FORCE INDEX(title) WHERE length(Title) > 100;
