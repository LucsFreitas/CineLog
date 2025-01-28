class Messages {
  static String appName = 'CineLog';

  // AppBar Title
  static String register = 'Cadastre-se';
  static String settings = 'Configurações';

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

  // Validations
  static String emailInvalidFormat = 'Deve ser um email válido';
  static String emailRequired = 'Email é obrigatório';
  static String passwordRequired = 'Senha é obrigatória';
  static String minLength(field, length) =>
      '$field deve conter ao menos $length caracteres';
  static String confirmPassWordRequired = 'Confirmação de senha é obrigatória';
  static String confirmPassWordDoesntMatch = 'Senhas informadas não conferem';

  // Messages
  static String userCreated = 'Usuário cadastrado com sucesso.';
  static String invalidCredencials = 'Credenciais inválidas.';
  static String loginError = 'Erro ao realizar login.';
  static String registerError = 'Erro ao realizar login.';
  static String emailAlreadyInUseError = 'Email já utilizado.';
  static String unexpectedError = 'Ocorreu um erro inesperado.';
}
