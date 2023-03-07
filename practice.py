
# import gzip
# import shutil
# with gzip.open('/home/mids/m256354/mambaforge/sd212/infochallenge/hurricane_florence.2018/2018_09_07_00_00_activities.json.gz', 'rb') as f_in:
#     with open('file.json', 'wb') as f_out:
#         shutil.copyfileobj(f_in, f_out)

# import json
# import gzip
# with gzip.open('/home/mids/m256354/mambaforge/sd212/infochallenge/hurricane_florence.2018/2018_09_07_00_00_activities.json.gz', 'rb') as f:
#     file_content = f.read()

# d = json.loads(file_content)
# print(d)

# with open('file.json') as fh:  # normal file open
#   d = json.load(fh)

# print(d)

import gzip
import json
d= json.loads("oneline.json")
print(d)