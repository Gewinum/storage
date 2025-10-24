cd /home/oracle
mkdir sample
wget https://github.com/oracle-samples/db-sample-schemas/archive/refs/tags/v23.3.tar.gz
tar -xvzf v23.3.tar.gz
mv db-sample-schemas-23.3 schemes
rm v23.3.tar.gz
cd schemes
perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat
mkdir logs
cd order_entry
sqlplus sys/oracle as sysdba <<'SQL'
ALTER USER HR IDENTIFIED BY hr ACCOUNT UNLOCK;
EXIT;
SQL
sqlplus sys/oracle as SYSDBA @oe_main.sql oe users temp hr oracle "/home/oracle/sample/schemes" "/home/oracle/sample/schemes/logs" v3 freepdb1 <<EOF
exit
EOF