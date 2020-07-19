## About Slice and Slice’s contents

In order to populate the wheel with content, you need to create a slice list and set it to `SwiftFortuneWheel`.

Each slice can be created with it’s `content` list and optional `backgroundColor` properties.

Currently, slice has 4 content types:

- **assetImage** creates an image with image name that specified in asset catalog;
- **image** creates an image with `UIImage/NSImage`;
- **text** creates a text, text could be vertical or horizontal;
- **line** creates a line inside a slice;

Each content will be added from the top to the bottom. Each content has its own preferences where you can specify a vertical or horizontal offset, size, font and etc.