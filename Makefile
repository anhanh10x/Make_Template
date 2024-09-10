# Biến compiler
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17 $(INCLUDES)

# Chế độ build
BUILD_TYPE := Release

# Cờ biên dịch cho từng chế độ
ifeq ($(BUILD_TYPE),DEBUG)
    CXXFLAGS += -g -O0
else
    CXXFLAGS += -O3
endif

# Thư mục chứa header và source
INCLUDES = 	\
-Ithirdparty	\

SOURCES =  \
main.cpp  \
thirdparty/foo.cpp	\
thirdparty/sum.cpp

OBJECTS = $(SOURCES:.cpp=.o)

# Thư mục thực thi
BUILD_DIR = build

# Tên file thực thi
TARGET = main

# Luật mặc định
all: $(BUILD_DIR) $(TARGET)

# Luật để tạo đối tượng thực thi
$(TARGET): $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o $@ $(addprefix $(BUILD_DIR)/,$(notdir $(OBJECTS)))

# Luật để tạo các tệp object từ các tệp .cpp
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $(BUILD_DIR)/$(patsubst %.cpp,%.o,$(notdir $<))

# Tạo thư mục build nếu chưa có
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

.PHONY: PRINT
# Phony target to print all include directories
clean:
	rm -f $(BUILD_DIR)/*.o $(TARGET)
