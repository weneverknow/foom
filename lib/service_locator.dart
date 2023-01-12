import 'package:foom/core/firestore/firestore_service.dart';
import 'package:foom/core/location/location_service.dart';
import 'package:foom/features/authentication/data/datasource/authentication_datasource.dart';
import 'package:foom/features/authentication/data/datasource/firebase_authentication.dart';
import 'package:foom/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:foom/features/authentication/domain/repository/authentication_repository.dart';
import 'package:foom/features/authentication/domain/usecase/create_account.dart';
import 'package:foom/features/authentication/domain/usecase/user_login.dart';
import 'package:foom/features/authentication/domain/usecase/user_logout.dart';
import 'package:foom/features/cart/data/datasource/cart_datasource.dart';
import 'package:foom/features/cart/data/repository/cart_repository_impl.dart';
import 'package:foom/features/cart/domain/repository/cart_repository.dart';
import 'package:foom/features/cart/domain/usecase/add_to_cart.dart';
import 'package:foom/features/cart/domain/usecase/delete_cart.dart';
import 'package:foom/features/cart/domain/usecase/fetch_cart.dart';
import 'package:foom/features/cart/domain/usecase/stream_cart.dart';
import 'package:foom/features/cart/domain/usecase/update_cart.dart';
import 'package:foom/features/category/data/datasource/category_datasource.dart';
import 'package:foom/features/category/data/repository/category_repository_impl.dart';
import 'package:foom/features/category/domain/repository/category_repository.dart';
import 'package:foom/features/category/domain/usecase/fetch_category.dart';
import 'package:foom/features/chat/data/datasource/chat_datasource.dart';
import 'package:foom/features/chat/data/repository/chat_repository_impl.dart';
import 'package:foom/features/chat/domain/repository/chat_repository.dart';
import 'package:foom/features/chat/domain/usecase/send_user_chat.dart';
import 'package:foom/features/chat/domain/usecase/stream_user_chat.dart';
import 'package:foom/features/checkout/data/datasource/checkout_datasource.dart';
import 'package:foom/features/checkout/data/repository/checkout_repository_impl.dart';
import 'package:foom/features/checkout/domain/repository/checkout_repository.dart';
import 'package:foom/features/checkout/domain/usecase/add_to_checkout.dart';
import 'package:foom/features/checkout/domain/usecase/fetch_checkouts.dart';
import 'package:foom/features/map/data/datasource/map_datasource.dart';
import 'package:foom/features/map/data/repository/map_repository_impl.dart';
import 'package:foom/features/map/domain/repository/map_repository.dart';
import 'package:foom/features/map/domain/usecase/fetch_address_from_map.dart';
import 'package:foom/features/product/data/datasource/product_datasource.dart';
import 'package:foom/features/product/data/repository/product_repository_impl.dart';
import 'package:foom/features/product/domain/repository/product_repository.dart';
import 'package:foom/features/product/domain/usecase/fetch_products.dart';
import 'package:foom/features/product/domain/usecase/fetch_products_from_firestore.dart';
import 'package:foom/features/profile/data/datasource/profile_datasource.dart';
import 'package:foom/features/profile/data/repository/profile_repository_impl.dart';
import 'package:foom/features/profile/domain/repository/profile_repository.dart';
import 'package:foom/features/profile/domain/usecase/fetch_member.dart';
import 'package:foom/features/profile/domain/usecase/stream_member.dart';
import 'package:foom/features/profile/domain/usecase/update_member.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

setupServiceLocator() {
  /**
   * Firebase authentication
   */
  sl.registerLazySingleton<FirebaseAuthentication>(
      () => FirebaseAuthenticationImpl());

  /**
       * Firestore service
       */
  sl.registerLazySingleton<FirestoreService>(() => FirestoreService());

  /**
   * location service
   */
  sl.registerLazySingleton<LocationService>(() => LocationService());

  /**
   * data source
   */

  sl.registerLazySingleton<ProductDataSource>(
      () => ProductDataSourceImpl(sl<FirestoreService>()));

  sl.registerLazySingleton<CartDatasource>(
      () => CartDatasourceImpl(sl<FirestoreService>()));

  sl.registerLazySingleton<CheckoutDatasource>(
      () => CheckoutDatasourceImpl(sl<FirestoreService>()));

  sl.registerLazySingleton<AuthenticationDatasource>(
      () => AuthenticationDatasourceImpl(sl<FirebaseAuthentication>()));

  sl.registerLazySingleton<CategoryDatasource>(
      () => CategoryDatasourceImpl(sl<FirestoreService>()));

  sl.registerLazySingleton<ProfileDatasource>(
      () => ProfileDatasourceImpl(sl<FirestoreService>()));

  sl.registerLazySingleton<ChatDatasource>(
      () => ChatDatasourceImpl(sl<FirestoreService>()));

  sl.registerLazySingleton<MapDatasource>(
      () => MapDatasourceImpl(sl<LocationService>()));

  /**
   * repository
   */
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl<ProductDataSource>()));

  sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(sl<CartDatasource>()));

  sl.registerLazySingleton<CheckoutRepository>(
      () => CheckoutRepositoryImpl(sl<CheckoutDatasource>()));
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl<AuthenticationDatasource>()));

  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(sl<CategoryDatasource>()));

  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl<ProfileDatasource>()));

  sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(sl<ChatDatasource>()));

  sl.registerLazySingleton<MapRepository>(
      () => MapRepositoryImpl(sl<MapDatasource>()));

  /**
   * usecase
   */
  sl.registerLazySingleton<FetchProducts>(
      () => FetchProducts(sl<ProductRepository>()));

  sl.registerLazySingleton<AddToCart>(() => AddToCart(sl<CartRepository>()));
  sl.registerLazySingleton<FetchCart>(() => FetchCart(sl<CartRepository>()));
  sl.registerLazySingleton<DeleteCart>(() => DeleteCart(sl<CartRepository>()));
  sl.registerLazySingleton<UpdateCart>(() => UpdateCart(sl<CartRepository>()));
  sl.registerLazySingleton<StreamCart>(() => StreamCart(sl<CartRepository>()));

  sl.registerLazySingleton<AddToCheckout>(
      () => AddToCheckout(sl<CheckoutRepository>()));
  sl.registerLazySingleton<FetchCheckouts>(
      () => FetchCheckouts(sl<CheckoutRepository>()));

  sl.registerLazySingleton<UserLogin>(
      () => UserLogin(sl<AuthenticationRepository>()));
  sl.registerLazySingleton<UserLogout>(
      () => UserLogout(sl<AuthenticationRepository>()));
  sl.registerLazySingleton<CreateAccount>(
      () => CreateAccount(sl<AuthenticationRepository>()));

  sl.registerLazySingleton<FetchProductsFromFirestore>(
      () => FetchProductsFromFirestore(sl<ProductRepository>()));

  sl.registerLazySingleton<FetchCategory>(
      () => FetchCategory(sl<CategoryRepository>()));

  sl.registerLazySingleton<StreamMember>(
      () => StreamMember(sl<ProfileRepository>()));
  sl.registerLazySingleton<UpdateMember>(
      () => UpdateMember(sl<ProfileRepository>()));
  sl.registerLazySingleton<FetchMember>(
      () => FetchMember(sl<ProfileRepository>()));

  sl.registerLazySingleton<StreamUserChat>(
      () => StreamUserChat(sl<ChatRepository>()));
  sl.registerLazySingleton<SendUserChat>(
      () => SendUserChat(sl<ChatRepository>()));

  sl.registerLazySingleton<FetchAddressFromMap>(
      () => FetchAddressFromMap(sl<MapRepository>()));
}
