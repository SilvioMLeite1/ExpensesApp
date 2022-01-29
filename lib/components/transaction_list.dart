import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                'Não há despesas cadastradas!',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            /*
      * A função map vai receber uma outra função e essa função vai receber
      * cada um dos elementos, neste caso vai receber uma transaction.
      * Em seguida converte um objeto do tipo transaction para um componente visual
      * Retorna no Widget Card que vai receber um valor textual do tipo transaction (tr.title) e no final
      * chama um toList para converter para uma lista e no final ter o resultado da lista dentro de children
      * associado a coluna.
      */
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 16,
                color: Colors.orange[400],
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text(
                        'R\$${tr.value}',
                        style: Theme.of(context).textTheme.headline6,
                      )),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('EEE d MMM y').format(tr.date),
                  ),
                  trailing: IconButton(
                    onPressed: () => onRemove(tr.id),
                    icon: Icon(Icons.delete_outline),
                    color: Colors.white,
                  ),
                ),
              );
            },
          );
  }
}
