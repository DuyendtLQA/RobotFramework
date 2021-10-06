import cv2

class CommonFc():
  @staticmethod
  def compare_images(path_image_one, path_image_two):
    image_one = cv2.imread(path_image_one)
    image_two = cv2.imread(path_image_two)
    if image_one.shape == image_two.shape:
      image_diff = cv2.subtract(image_one, image_two)
      b, g, r = cv2.split(image_diff)

      if cv2.countNonZero(b) == 0 and cv2.countNonZero(g) == 0 and cv2.countNonZero(r) == 0:
        # print("The images are completely Equal")
        return 0
      else:
        # print("the images are same size but not equal1")
        return 1
    else:
      # print("the images are not equal")
      return 1

  @staticmethod
  def remove_spaces_string(str_temp):
      return  ' '.join(str_temp.split())

  def check_list_desc(self, test_list):
    flag = False
    test_list1 = test_list[:]
    test_list1.sort()
    if (test_list1 == test_list):
        flag = True
    return flag
