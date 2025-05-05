class Messages {
  static String appName = 'CineLog';

  // AppBar Title
  static String register = 'Cadastre-se';
  static String settings = 'Configurações';
  static String exclude = 'Excluir';

  // Labels
  static String email = 'Email';
  static String password = 'Senha';
  static String confirmPassword = 'Confirme a senha';
  static String forgotPassword = 'Esqueceu a senha?';
  static String login = 'Login';
  static String save = 'Salvar';
  static String continueWithGoogle = 'Continue com o Google';
  static String hasNotAccount = 'Não tem conta?';
  static String registerNow = 'Cadastre-se';
  static String searchInput = 'Pesquisar...';
  static String toWatch = 'Para assistir';
  static String watched = 'Assistidos';
  static String addMovie = 'Adicionar filme';
  static String overview = 'Sinopse';
  static String releaseDate = 'Data';
  static String addToLibrary = 'Adicionar à biblioteca';
  static String markAsWatched = 'Marcar como assistido';
  static String votes = 'votos';
  static String details = 'Detalhes';

  // Movies
  static String overviewNotAvailable = 'Sinopse não disponível.';
  static String titleNotAvailable = 'Título não disponível.';

  // Validations
  static String emailInvalidFormat = 'Deve ser um email válido';
  static String emailRequired = 'Email é obrigatório';
  static String passwordRequired = 'Senha é obrigatória';
  static String minLength(field, length) =>
      '$field deve conter ao menos $length caracteres';
  static String confirmPassWordRequired = 'Confirmação de senha é obrigatória';
  static String confirmPassWordDoesntMatch = 'Senhas informadas não conferem';

  // Messages
  static String unexpectedError = 'Ocorreu um erro inesperado.';
  static String userCreated = 'Usuário cadastrado com sucesso.';
  static String invalidCredencials =
      'Credenciais inválidas ou método de acesso incorreto.';
  static String loginError = 'Erro ao realizar login.';
  static String registerError = 'Erro ao realizar login.';
  static String emailAlreadyInUseError = 'Email já utilizado.';
  static String typeAnEmailToRecoverPassword =
      'Digite um email para recuperar a senha.';
  static String forgotPasswordError = 'Erro ao tentar recuperar a senha.';
  static String recoverPasswordEmaiLSent =
      'Caso o email esteja cadastrado, você receberá um email de recuperação de senha.';
  static String userAlreadyExists = 'Usuário já cadastrado com outro mecanismo';
  static String googleLoginError = 'Erro ao logar via google';
  static String doFillName = 'Preencha um nome';
  static String? failedFindMovies = 'Houve um erro ao tentar buscar filmes.';
  static String? failedSaveMovies = 'Houve um erro ao tentar salvar filme.';
}
