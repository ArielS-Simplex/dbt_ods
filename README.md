1. clone this project:
on pycharm terminal copy this:

 git clone https://github.com/ArielS-Simplex/dbt_ods.git

2. run ``` docker build -t dbt_ods . ```

3. run  ```docker run -it   --name dbt_ods_container   -p 8580:8580   dbt_ods```

4.  dbt debug


for the airflow project:
you need to install: 
pymysql (no specific version)
apache-airflow-providers-docker==3.7.5


I've added the Airflow docker folder 