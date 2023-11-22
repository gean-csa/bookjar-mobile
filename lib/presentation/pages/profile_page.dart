import '../../constants/colors.dart';
import '../../constants/texts_styles.dart';
import '../../mock/favorite_books.dart';
import '../../mock/user.dart';
import '../../presentation/widgets/book_list.dart';
import 'package:flutter/material.dart';

// É a classe que define a página de perfil do usuario.
// Extende StatefulWidget para atender à suas mudanças de estado (Ex.: Alteração do nome de usuário).
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // Através do método 'initState' checamos se o usuário ainda não foi renomeado durante a inicialização da própria pagina,
    // exibindo a caixa de dialogo imediatamente, se for o caso.
    super.initState();
    if (isGuest == true) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        final textController = TextEditingController();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Digite seu nome de usuário:',
              style: subheader,
            ),
            content: TextField(
              controller: textController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Usuário'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Ao pressionar o botão no popup, será atualizado o nome do usuário e o estado da página através do método 'setState()'
                  setState(() {
                    username = textController.text;
                  });
                  isGuest = false;
                },
                child: const Text(
                  "Enviar",
                  style: subheader,
                ),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 'Scaffold' é o widget principal para a criação da estrutura da página.
    return Scaffold(
      appBar: AppBar(
        title: const Text("BookJar"),
        backgroundColor: primary,
        actions: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: IconButton(
              onPressed: () {
                // Botão retorna à pagina inicial, fazendo 'pop' desta pagina na pilha de navigação.
                Navigator.pop(context);
              },
              icon: const Icon(Icons.home),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32.0,
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: title,
              ),
              const SizedBox(height: 4),
              if (favoriteBooks.isEmpty)
                Text("Não há livros favoritos", style: subheader)
              else
                Text("$favoritesLength livros favoritos", style: subheader),
              const SizedBox(height: 24),
              BookList(bookList: favoriteBooks),
            ],
          ),
        ),
      ),
    );
  }
}
