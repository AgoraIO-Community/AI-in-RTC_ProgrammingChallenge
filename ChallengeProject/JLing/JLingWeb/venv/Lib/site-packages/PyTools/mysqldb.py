import pymysql
import time
import os
import subprocess
import logging

__all__ = ["PyMysqlDB"]
logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s [%(levelname)s] %(funcName)s: %(message)s',
                    datefmt="%d %b %Y %H:%M:%S")


class PyMysqlDB:
    def __init__(self, host=None, user=None, pwd=None, port=3306, base_path=None, backup_path='/data/LocalBackup'):
        self.host = host
        self.user = user
        self.pwd = pwd
        self.port = int(port)
        self.base_path = base_path
        self.backup_path = backup_path

    def select_database(self):
        db_list = []
        con = pymysql.connect(host=self.host, user=self.user, password=self.pwd, db='information_schema',
                              port=self.port)
        cur = con.cursor()
        cur.execute('select SCHEMA_NAME from SCHEMATA')
        for (db,) in cur.fetchall():
            db_list.append(db)
        return db_list

    def backup_by_database(self, database):
        logging.info('backup database: {}'.format(database))
        today = time.strftime("%Y%m%d", time.localtime())
        backup_dir = '{}/{}'.format(self.backup_path, today)
        if not os.path.isdir(backup_dir):
            os.makedirs(backup_dir)
        os.chdir(backup_dir)
        start_time = int(time.time())
        cmd = "{}/bin/mysqldump --opt -h{} -P{} -u{} -p{} {} | gzip > {}/{}/{}-{}-{}.sql.gz".format(self.base_path,
                                                                                                    self.host,
                                                                                                    self.port,
                                                                                                    self.user, self.pwd,
                                                                                                    database,
                                                                                                    self.backup_path,
                                                                                                    today, today,
                                                                                                    self.host,
                                                                                                    database)
        result = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        content = result.stdout.read()
        if content:
            subject = "{} - {} backup error, reason: {}".format(self.host, database, content.decode())
            logging.error(subject)
        end_time = int(time.time())
        use_time = end_time - start_time
        logging.info('{} - {} backup finished, use time: {}s'.format(self.host, database, float('%.2f' % use_time)))

    def backup_by_table(self):
        pass

    def backup_all(self, **kwargs):
        exclude_db = kwargs.get('exclude_db', [])
        db_list = [val for val in self.select_database() if val not in exclude_db]
        logging.info('db_list: {}'.format(db_list))
        for db in db_list:
            self.backup_by_database(db)
            logging.info('{} backup all finished'.format(self.host))
