import { Lambda } from "aws-sdk";
import { NextApiRequest, NextApiResponse } from "next";

const lambda = new Lambda({
  region: process.env.VPC_AWS_REGION,
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
});

export default async (req: NextApiRequest, res: NextApiResponse) => {
  lambda.invoke(
    {
      FunctionName: process.env.VPC_LAMBDA_FUNCTION_NAME!,
      Payload: JSON.stringify({}),
    },
    (err, data) => {
      if (err) {
        console.log(err);
        res.status(500).json({ error: err });
      } else {
        res.status(200).json({ data });
      }
    }
  );
};
