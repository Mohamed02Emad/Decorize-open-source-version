class CreateDesignUrls {
  //todo : add ai base url here
  static String aiBaseUrl =
      'put yours here';
  static String getModelUrl = 'model-url';
  static uploadImage(String projectId) => '/editor/$projectId/upload';
  static segments(String projectId) => '/editor/$projectId/segment';
  static changeColor(String projectId) => '/editor/$projectId/change-color';
  static changeTexture(String projectId) => '/editor/$projectId/change-texture';
  static String saveProject = '/auth/generated-images/store';
  static exitProject(String projectId) => '/editor/$projectId/exit';
  static openProject(String projectId) => '/editor/$projectId/open';
  static suggestDesign(String projectId) => '/designer/$projectId/generate';
  static reSuggestDesign(String projectId) => '/designer/$projectId/regenerate';
  static String textures = '/auth/textures';
}
