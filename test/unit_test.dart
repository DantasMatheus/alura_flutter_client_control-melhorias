import 'package:client_control/models/client.dart';
import 'package:client_control/models/client_type.dart';
import 'package:client_control/models/clients.dart';
import 'package:client_control/models/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Clients Test', () {
    final junior = Client(
      name: 'Junior',
      email: 'junior@mail.com',
      type: ClientType(name: 'Premium', icon: Icons.star),
    );

    test('Client model should add new client', () {
      var clients = Clients(clients: []);
      clients.add(junior);
      clients.add(junior);
      expect(clients.clients, [junior, junior]);
    });

    test('Client model should remove a client', () {
      var clients = Clients(clients: [junior, junior, junior]);
      clients.remove(0);
      clients.remove(1);
      expect(clients.clients, [junior]);
    });
  });

  group('Types Test', () {
    final gold = ClientType(name: 'Gold', icon: Icons.workspace_premium);

    test('Types model should add new type', () {
      var types = Types(types: []);
      types.add(gold);
      types.add(gold);
      expect(types.types, [gold, gold]);
    });

    test('Client model should remove a client', () {
      var clients = Types(types: [gold, gold, gold]);
      clients.remove(0);
      clients.remove(1);
      expect(clients.types, [gold]);
    });
  });
}
