import 'package:enricoui/enricoui.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  MyCard({super.key});
  EHttpUtil edio = EHttpUtil();
  final database = ESQLite(uuid: "unique-user-id");
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ECard(
          onTap: () {
            print('Card tapped');
            edio.init(
                baseUrl: "https://wechat.gitbili.com",
                proxyUrl: "192.168.1.90:8889");
            edio.get("/api/v1/wechat/login").then((value) {
              print(value);
            });
          },
          cardColor: Colors.blue,
          shadowColor: Colors.black,
          borderRadius: 20,
          elevation: 5,
          height: 200,
          width: 300,
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          child: const Center(child: Text('Hello, World!')),
        ),
        ECard(
          onTap: () async {
            // 初始化数据库
            // 插入数据
            final insertId = await database.insertData({
              'name': 'Alice',
              'age': 30,
            });
            print('插入数据的ID: $insertId');

            // 更新数据
            final updatedRows = await database.updateData(
              {'name': 'Bob'},
              {'id': insertId},
            );
            print('更新的行数: $updatedRows');

            // 查询数据
            final data =
                await database.query(where: {"uuid": "unique-user-id"});
            print('查询结果: $data');

            // 删除数据
            final deletedRows = await database.delete(where: {'name': "Bob"});
            print('删除的行数: $deletedRows');

            // 关闭数据库
            // database.closeDatabase();
          },
          cardColor: Colors.blue,
          shadowColor: Colors.black,
          borderRadius: 20,
          elevation: 5,
          height: 100,
          width: 300,
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          child: const Center(
              child: Text(
            '测试Sqlite',
            style: TextStyle(color: Colors.white, fontSize: 30),
          )),
        ),
      ],
    );
  }
}
